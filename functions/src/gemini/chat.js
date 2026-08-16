const { onCall, HttpsError } = require("firebase-functions/v2/https");
const { defineSecret } = require("firebase-functions/params");

const geminiApiKey = defineSecret("GEMINI_API_KEY");

exports.chatWithGemini = onCall({ secrets: [geminiApiKey] }, async (request) => {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "User must be logged in to chat.");
  }

  const { message } = request.data;
  if (!message || typeof message !== 'string' || message.trim().length === 0) {
    throw new HttpsError("invalid-argument", "Message cannot be empty.");
  }

  if (message.length > 1000) {
    throw new HttpsError("invalid-argument", "Message is too long.");
  }

  const { GoogleGenAI } = require('@google/genai');

  try {
    const ai = new GoogleGenAI({ apiKey: geminiApiKey.value() });
    
    // Using gemini-2.5-flash as the fast standard chat model
    const response = await ai.models.generateContent({
      model: 'gemini-2.5-flash',
      contents: message,
      config: {
        systemInstruction: "You are Dekozy, an AI assistant for an e-commerce store.",
      }
    });

    return { text: response.text };
  } catch (error) {
    console.error("Gemini API error:", error);
    throw new HttpsError("internal", "Failed to generate response.");
  }
});
