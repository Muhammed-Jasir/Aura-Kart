import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  final apiKey = dotenv.env['GEMINI_API_KEY_1'] ?? '';
  
  if (apiKey.isEmpty) {
    print('API Key is empty!');
    exit(1);
  }

  print('Testing API Key: \${apiKey.substring(0, 5)}...');
  
  final modelsToTest = ['gemini-1.5-flash', 'gemini-pro', 'gemini-1.0-pro'];
  
  for (final modelName in modelsToTest) {
    print('\\nTesting model: \$modelName');
    try {
      final model = GenerativeModel(
        model: modelName,
        apiKey: apiKey,
      );
      
      final response = await model.generateContent([Content.text('Say exactly: Hello')]);
      print('✅ SUCCESS! Response: \${response.text}');
    } catch (e) {
      print('❌ FAILED: \$e');
    }
  }
  exit(0);
}
