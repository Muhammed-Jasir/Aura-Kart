import 'package:aurakart/features/chatbot/models/chat_model.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  TextEditingController promptController = TextEditingController();
  final model = GenerativeModel(model: "gemini-pro", apiKey: apiKey);
  final List<ModelMessage> prompt = [];

  Future<void> sendMessage() async {
    final message = promptController.text;
    setState(() {
      promptController.clear();
      prompt.add(ModelMessage(
        isPrompt: true,
        message: message,
        time: DateTime.now(),
      ));
    });

    final content = [Content.text(message)];
    final response = await model.generateContent(content);

    setState(() {
      prompt.add(ModelMessage(
        isPrompt: false,
        message: response.text ?? "",
        time: DateTime.now(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: AColors.primary,
        title: const Text("Aurabot"),
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              AImages.chatImage,
              fit: BoxFit.cover,
            ),
          ),

          // Chat UI
          Positioned.fill(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: prompt.length,
                    itemBuilder: (context, index) {
                      final message = prompt[index];
                      return userPrompt(
                        isPrompt: message.isPrompt,
                        date: DateFormat('hh:mm a').format(message.time),
                        message: message.message,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 20,
                        child: TextField(
                          controller: promptController,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: "Type here...",
                          ),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          sendMessage();
                        },
                        child: const CircleAvatar(
                          radius: 29,
                          backgroundColor: Color.fromARGB(255, 247, 130, 130),
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Chat Bubble Widget
Container userPrompt({
  required final bool isPrompt,
  required String date,
  required String message,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(15),
    margin: const EdgeInsets.symmetric(vertical: 15).copyWith(
      left: isPrompt ? 80 : 15,
      right: isPrompt ? 15 : 80,
    ),
    decoration: BoxDecoration(
      color: isPrompt ? const Color.fromARGB(255, 247, 130, 130) : Colors.grey,
      borderRadius: BorderRadius.only(
        topLeft: const Radius.circular(20),
        topRight: const Radius.circular(20),
        bottomLeft: isPrompt ? const Radius.circular(20) : Radius.zero,
        bottomRight: isPrompt ? Radius.zero : const Radius.circular(20),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          message,
          style: TextStyle(
            fontWeight: isPrompt ? FontWeight.bold : FontWeight.normal,
            fontSize: 18,
            color: isPrompt ? Colors.white : Colors.black,
          ),
        ),
        Text(
          date,
          style: TextStyle(
            fontSize: 14,
            color: isPrompt ? Colors.white : Colors.black,
          ),
        ),
      ],
    ),
  );
}

// ModelMessage Class
class ModelMessage {
  final bool isPrompt;
  final String message;
  final DateTime time;

  ModelMessage({
    required this.isPrompt,
    required this.message,
    required this.time,
  });
}
