// List OF Constants used in APIs

import 'package:flutter_dotenv/flutter_dotenv.dart';

class APIConstants {
  static String cloudinaryUploadPreset =
      dotenv.env['CLOUDINARY_UPLOAD_PRESET'] ?? "aura_kart_preset";
  static String cloudinaryApiKey = dotenv.env['CLOUDINARY_API_KEY'] ?? '';
  static String cloudinaryApiSecret = dotenv.env['CLOUDINARY_API_SECRET'] ?? '';
  static String cloudinaryCloudName = dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? '';

  static String openAIApiKey = dotenv.env['OPENAI_API_KEY'] ?? '';

  static getCloudinaryUploadUrl(String cloudName, String resourceType) {
    return 'https://api.cloudinary.com/v1_1/$cloudName/$resourceType/upload';
  }

  static getCloudinaryDeleteUrl(String cloudName, String resourceType) {
    return 'https://api.cloudinary.com/v1_1/$cloudName/$resourceType/destroy';
  }
}
