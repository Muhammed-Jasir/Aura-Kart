const { onCall, HttpsError } = require("firebase-functions/v2/https");
const { defineSecret } = require("firebase-functions/params");
const admin = require("firebase-admin");
const stripeSecret = defineSecret("STRIPE_SECRET_KEY");

exports.cancelOrder = onCall({ secrets: [stripeSecret] }, async (request) => {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "User must be logged in to cancel an order.");
  }

  const userId = request.auth.uid;
  const { orderId } = request.data;

  if (!orderId) {
    throw new HttpsError("invalid-argument", "Order ID is required.");
  }

  const db = admin.firestore();
  const orderRef = db.collection("Orders").doc(orderId);
  const orderSnap = await orderRef.get();

  if (!orderSnap.exists) {
    throw new HttpsError("not-found", "Order not found.");
  }

  const orderData = orderSnap.data();

  if (orderData.userId !== userId) {
    throw new HttpsError("permission-denied", "You can only cancel your own orders.");
  }

  if (orderData.status !== "OrderStatus.pending" && orderData.status !== "OrderStatus.processing") {
    throw new HttpsError("failed-precondition", "Order cannot be cancelled at this stage.");
  }

  // If order was paid via Stripe, we must issue a refund.
  if (orderData.paymentMethod === "Stripe" && orderData.paymentStatus === "paid" && orderData.paymentIntentId) {
    try {
      const stripe = require("stripe")(stripeSecret.value());
      await stripe.refunds.create({
        payment_intent: orderData.paymentIntentId,
      });
    } catch (error) {
      console.error("Stripe Refund Failed: ", error);
      throw new HttpsError("internal", "Order could not be cancelled because the refund failed.");
    }
  }

  await orderRef.update({
    status: "OrderStatus.cancelled",
    paymentStatus: (orderData.paymentStatus === "paid") ? "refunded" : "cancelled"
  });

  return { success: true };
});
