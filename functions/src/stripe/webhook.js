const { onRequest } = require("firebase-functions/v2/https");
const { defineSecret } = require("firebase-functions/params");
const admin = require("firebase-admin");

const stripeSecret = defineSecret("STRIPE_SECRET_KEY");
const webhookSecret = defineSecret("STRIPE_WEBHOOK_SECRET");

exports.webhook = onRequest({ secrets: [stripeSecret, webhookSecret] }, async (req, res) => {
  const sig = req.headers["stripe-signature"];
  const stripe = require("stripe")(stripeSecret.value());

  let event;

  try {
    // Verify webhook signature (raw body is required for Stripe signature verification)
    event = stripe.webhooks.constructEvent(req.rawBody, sig, webhookSecret.value());
  } catch (err) {
    console.error(`Webhook Error: ${err.message}`);
    res.status(400).send(`Webhook Error: ${err.message}`);
    return;
  }

  const db = admin.firestore();

  // Webhook Idempotency: Have we processed this event already?
  const eventRef = db.collection("StripeEvents").doc(event.id);
  const eventDoc = await eventRef.get();
  if (eventDoc.exists) {
    console.log(`Event ${event.id} already processed.`);
    res.json({ received: true, alreadyProcessed: true });
    return;
  }

  if (event.type === 'payment_intent.succeeded' || event.type === 'payment_intent.payment_failed' || event.type === 'payment_intent.canceled') {
    const paymentIntent = event.data.object;
    const orderId = paymentIntent.metadata.orderId;
    
    if (!orderId) {
      console.error('PaymentIntent missing orderId metadata');
      // Acknowledge receipt but we can't process it.
      await eventRef.set({ processedAt: admin.firestore.FieldValue.serverTimestamp(), status: 'ignored_missing_metadata' });
      res.json({ received: true });
      return;
    }

    try {
      await db.runTransaction(async (transaction) => {
        const orderRef = db.collection("Orders").doc(orderId);
        const orderSnap = await transaction.get(orderRef);

        if (!orderSnap.exists) {
          throw new Error(`Order ${orderId} does not exist.`);
        }

        const order = orderSnap.data();

        // Security Verifications
        if (order.paymentIntentId !== paymentIntent.id) {
          throw new Error(`PaymentIntent mismatch. Expected ${order.paymentIntentId}, got ${paymentIntent.id}`);
        }
        if (order.userId !== paymentIntent.metadata.userId) {
          throw new Error(`User mismatch. Expected ${order.userId}, got ${paymentIntent.metadata.userId}`);
        }
        
        // Amount verification
        const expectedStripeAmount = Math.round(order.totalAmount * 100);
        if (paymentIntent.amount !== expectedStripeAmount) {
          throw new Error(`Amount mismatch. Expected ${expectedStripeAmount}, got ${paymentIntent.amount}`);
        }

        // State machine logic
        let newPaymentStatus = order.paymentStatus;
        let newOrderStatus = order.status;

        if (event.type === 'payment_intent.succeeded') {
          if (order.paymentStatus === 'paid') return; // Idempotent bail inside transaction
          newPaymentStatus = 'paid';
          newOrderStatus = 'OrderStatus.processing'; // Move to processing
        } else if (event.type === 'payment_intent.payment_failed') {
          if (order.paymentStatus === 'failed') return;
          newPaymentStatus = 'failed';
        } else if (event.type === 'payment_intent.canceled') {
          if (order.paymentStatus === 'cancelled') return;
          newPaymentStatus = 'cancelled';
          newOrderStatus = 'OrderStatus.cancelled';
        }

        // Apply update
        transaction.update(orderRef, {
          paymentStatus: newPaymentStatus,
          status: newOrderStatus
        });
        
        // Mark event as processed
        transaction.set(eventRef, {
          processedAt: admin.firestore.FieldValue.serverTimestamp(),
          type: event.type,
          orderId: orderId
        });
      });

    } catch (error) {
      console.error(`Transaction failed for event ${event.id}:`, error);
      res.status(500).send('Internal Server Error');
      return;
    }
  } else {
    // Unhandled event type, but acknowledge receipt to prevent retries
    await eventRef.set({ processedAt: admin.firestore.FieldValue.serverTimestamp(), status: 'ignored_unhandled_type' });
  }

  // Return a 200 response to acknowledge receipt of the event
  res.json({ received: true });
});
