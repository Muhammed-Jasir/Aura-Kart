import 'package:aurakart/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final bool isPrompt;
  final String message;
  final String time;

  const ChatBubble({
    required this.isPrompt,
    required this.message,
    required this.time,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isPrompt ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        decoration: BoxDecoration(
          color: isPrompt ? AColors.primary : Colors.grey[300],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: isPrompt ? const Radius.circular(20) : Radius.zero,
            bottomRight: isPrompt ? Radius.zero : const Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: TextStyle(
                fontSize: 16,
                color: isPrompt ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              time,
              style: TextStyle(
                  fontSize: 12,
                  color: isPrompt ? Colors.white70 : Colors.black45),
            ),
          ],
        ),
      ),
    );
  }
}
