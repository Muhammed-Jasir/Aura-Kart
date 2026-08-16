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
    final darkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment:
            isPrompt ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isPrompt) ...[
            Container(
              margin: const EdgeInsets.only(right: 8),
              child: const CircleAvatar(
                radius: 16,
                backgroundColor: AColors.primary,
                child: Icon(Icons.auto_awesome, color: Colors.white, size: 18),
              ),
            ),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                gradient: isPrompt
                    ? const LinearGradient(
                        colors: [Color(0xFF00C6FF), Color(0xFF0072FF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: isPrompt
                    ? null
                    : (darkMode ? const Color(0xFF2C2C2E) : Colors.white),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: isPrompt
                      ? const Radius.circular(20)
                      : const Radius.circular(4),
                  bottomRight: isPrompt
                      ? const Radius.circular(4)
                      : const Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
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
                      color: isPrompt
                          ? Colors.white
                          : (darkMode ? Colors.white : Colors.black87),
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 11,
                      color: isPrompt
                          ? Colors.white.withValues(alpha: 0.7)
                          : (darkMode ? Colors.white54 : Colors.black45),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isPrompt) ...[
            Container(
              margin: const EdgeInsets.only(left: 8),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.grey.shade300,
                child: const Text('👤', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
