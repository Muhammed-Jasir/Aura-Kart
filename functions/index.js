const { onRequest, onCall } = require("firebase-functions/v2/https");
const { setGlobalOptions } = require("firebase-functions/v2");
const admin = require("firebase-admin");

admin.initializeApp();

// Set global options (max timeout, memory, etc. if needed)
setGlobalOptions({ maxInstances: 10, region: "us-central1" });

const { createOrderAndPaymentIntent } = require('./src/stripe/createPaymentIntent');
const { webhook } = require('./src/stripe/webhook');
const { deleteCloudinaryImage } = require('./src/cloudinary/deleteImage');
const { chatWithGemini } = require('./src/gemini/chat');
const { createCODOrder } = require('./src/orders/createCODOrder');
const { cancelOrder } = require('./src/orders/cancelOrder');

exports.createOrderAndPaymentIntent = createOrderAndPaymentIntent;
exports.webhook = webhook;
exports.deleteCloudinaryImage = deleteCloudinaryImage;
exports.chatWithGemini = chatWithGemini;
exports.createCODOrder = createCODOrder;
exports.cancelOrder = cancelOrder;
