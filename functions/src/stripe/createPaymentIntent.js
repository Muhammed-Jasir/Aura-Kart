const { onCall, HttpsError } = require("firebase-functions/v2/https");
const { defineSecret } = require("firebase-functions/params");
const admin = require("firebase-admin");
const stripeSecret = defineSecret("STRIPE_SECRET_KEY");

exports.createOrderAndPaymentIntent = onCall({ secrets: [stripeSecret] }, async (request) => {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "User must be logged in to checkout.");
  }

  const userId = request.auth.uid;
  const { items, shippingAddressId, billingAddressId, idempotencyKey } = request.data;

  if (!items || !Array.isArray(items) || items.length === 0) {
    throw new HttpsError("invalid-argument", "Cart cannot be empty.");
  }
  if (!idempotencyKey) {
    throw new HttpsError("invalid-argument", "Idempotency key required.");
  }

  const db = admin.firestore();

  // 1. Check idempotency. Have we already processed this checkout request?
  const idempotencyRef = db.collection("Users").doc(userId).collection("Checkouts").doc(idempotencyKey);
  const existingCheckout = await idempotencyRef.get();
  if (existingCheckout.exists) {
    return existingCheckout.data(); // Contains clientSecret and orderId
  }

  // 2. Validate addresses
  let shippingAddress = null;
  let billingAddress = null;
  
  if (shippingAddressId) {
    const sSnap = await db.collection("Users").doc(userId).collection("Addresses").doc(shippingAddressId).get();
    if (!sSnap.exists) throw new HttpsError("not-found", "Shipping address not found.");
    shippingAddress = sSnap.data();
    shippingAddress.Id = sSnap.id;
  }
  
  if (billingAddressId) {
    const bSnap = await db.collection("Users").doc(userId).collection("Addresses").doc(billingAddressId).get();
    if (bSnap.exists) {
      billingAddress = bSnap.data();
      billingAddress.Id = bSnap.id;
    }
  }

  // 3. Process items and authoritative prices
  let totalAmount = 0;
  const finalItems = [];

  for (const item of items) {
    const { productId, variationId, quantity } = item;
    
    if (quantity <= 0) {
      throw new HttpsError("invalid-argument", "Quantity must be greater than 0.");
    }

    const pSnap = await db.collection("Products").doc(productId).get();
    if (!pSnap.exists) {
      throw new HttpsError("not-found", `Product ${productId} not found.`);
    }

    const product = pSnap.data();
    let priceToConsider = 0;
    let title = product.Title || '';
    let image = product.Thumbnail || '';
    let brandName = product.Brand ? product.Brand.Name : null;

    if (product.ProductType === 'single' || !variationId) {
      if (product.Stock < quantity) {
        throw new HttpsError("failed-precondition", `Insufficient stock for ${title}.`);
      }
      priceToConsider = (product.SalePrice > 0) ? product.SalePrice : product.Price;
    } else {
      // Variable product
      const variations = product.ProductVariations || [];
      const variation = variations.find(v => v.Id === variationId);
      if (!variation) {
        throw new HttpsError("not-found", `Variation not found for product ${productId}.`);
      }
      if (variation.Stock < quantity) {
        throw new HttpsError("failed-precondition", `Insufficient stock for variation of ${title}.`);
      }
      priceToConsider = (variation.SalePrice > 0) ? variation.SalePrice : variation.Price;
      if (variation.Image) image = variation.Image;
    }

    const lineTotal = priceToConsider * quantity;
    totalAmount += lineTotal;

    finalItems.push({
      productId,
      variationId: variationId || '',
      quantity,
      price: priceToConsider, // Authoritative price snapshot
      title,
      image,
      brandName
    });
  }

  // In production, add shipping and tax logic here. 
  const shippingCost = 0;
  const taxCost = 0;
  totalAmount += (shippingCost + taxCost);

  // 4. Create Stripe PaymentIntent
  const stripe = require("stripe")(stripeSecret.value());
  const orderId = db.collection("Orders").doc().id;

  const paymentIntent = await stripe.paymentIntents.create({
    amount: Math.round(totalAmount * 100), // Stripe expects smallest currency unit (e.g. paise for INR)
    currency: "inr", // Assuming INR as per existing Dekozy logic
    metadata: {
      orderId: orderId,
      userId: userId,
    },
    idempotencyKey: idempotencyKey, // Use same key for Stripe idempotency
  });

  // 5. Create Pending Order in Firestore
  const orderData = {
    id: orderId,
    userId,
    status: "OrderStatus.pending", // Must match Dekozy's OrderStatus.pending.toString()
    paymentStatus: "pending",
    paymentIntentId: paymentIntent.id,
    totalAmount,
    shippingCost,
    taxCost,
    orderDate: admin.firestore.FieldValue.serverTimestamp(),
    paymentMethod: "Stripe",
    items: finalItems,
    shippingAddress: shippingAddress,
    billingAddress: billingAddress,
    billingAddressSameAsShipping: (shippingAddressId === billingAddressId),
  };

  await db.collection("Orders").doc(orderId).set(orderData);

  const responseData = {
    clientSecret: paymentIntent.client_secret,
    orderId: orderId,
  };

  // 6. Save idempotency record
  await idempotencyRef.set(responseData);

  return responseData;
});
