const { onCall, HttpsError } = require("firebase-functions/v2/https");
const { defineSecret } = require("firebase-functions/params");
const admin = require("firebase-admin");

const cloudinaryApiSecret = defineSecret("CLOUDINARY_API_SECRET");

// Assuming API Key and Cloud Name are safe to be public or can be passed as config.
// For maximum security, you might want to also make them secrets or env vars.
// We will use standard env params or hardcode the known public ones if needed, 
// but it's best to extract them dynamically or assume they are provided in env.
const CLOUDINARY_API_KEY = process.env.CLOUDINARY_API_KEY || "your_api_key_here";
const CLOUDINARY_CLOUD_NAME = process.env.CLOUDINARY_CLOUD_NAME || "dveb42k0p";

function extractPublicIdFromUrl(url) {
  // Typical Cloudinary URL: https://res.cloudinary.com/<cloud_name>/image/upload/v1234567890/folder/image_name.png
  try {
    const parts = url.split('/');
    const uploadIndex = parts.indexOf('upload');
    if (uploadIndex === -1) return null;
    
    // The public ID is everything after the version number (e.g. v1234567890) up to the extension
    // Sometimes there is no version number.
    let pathParts = parts.slice(uploadIndex + 1);
    if (pathParts[0].startsWith('v') && !isNaN(pathParts[0].substring(1))) {
      pathParts.shift(); // Remove version
    }
    
    const fullPath = pathParts.join('/');
    const lastDotIndex = fullPath.lastIndexOf('.');
    if (lastDotIndex === -1) return fullPath;
    return fullPath.substring(0, lastDotIndex);
  } catch (e) {
    return null;
  }
}

exports.deleteCloudinaryImage = onCall({ secrets: [cloudinaryApiSecret] }, async (request) => {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "User must be logged in.");
  }

  const userId = request.auth.uid;
  const db = admin.firestore();

  const userSnap = await db.collection("Users").doc(userId).get();
  if (!userSnap.exists) {
    throw new HttpsError("not-found", "User document not found.");
  }

  const userData = userSnap.data();
  const profilePictureUrl = userData.ProfilePicture;

  if (!profilePictureUrl) {
    throw new HttpsError("failed-precondition", "User does not have a profile picture.");
  }

  const publicId = extractPublicIdFromUrl(profilePictureUrl);
  if (!publicId) {
    throw new HttpsError("internal", "Could not extract public ID from profile picture URL.");
  }

  const cloudinary = require('cloudinary').v2;
  cloudinary.config({
    cloud_name: CLOUDINARY_CLOUD_NAME,
    api_key: CLOUDINARY_API_KEY,
    api_secret: cloudinaryApiSecret.value()
  });

  try {
    const result = await cloudinary.uploader.destroy(publicId);
    if (result.result !== 'ok' && result.result !== 'not found') {
      throw new Error(`Cloudinary error: ${result.result}`);
    }
    
    // Optionally update Firestore to clear the image
    await db.collection("Users").doc(userId).update({
      ProfilePicture: ""
    });

    return { success: true, message: "Profile picture deleted successfully." };
  } catch (error) {
    console.error("Cloudinary deletion failed:", error);
    throw new HttpsError("internal", "Failed to delete image from Cloudinary.");
  }
});
