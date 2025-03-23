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
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        decoration: BoxDecoration(
          color: isPrompt ? const Color(0xFFF78282) : Colors.grey[300],
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
                  fontSize: 16, color: isPrompt ? Colors.white : Colors.black),
            ),
            const SizedBox(height: 5),
            Text(
              time,
              style: TextStyle(
                  fontSize: 12,
                  color: isPrompt ? Colors.white70 : Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:aurakart/utils/constants/sizes.dart';
// import 'package:aurakart/utils/helpers/helper_functions.dart';

// class ChatBubble extends StatelessWidget {
//   final bool isPrompt;
//   final String message;
//   final String date;

//   const ChatBubble({
//     super.key,
//     required this.isPrompt,
//     required this.message,
//     required this.date,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final isDarkMode = AHelperFunctions.isDarkMode(context);

//     final bubbleColor = isPrompt
//         ? Colors.blue
//         : isDarkMode
//             ? Colors.grey[800]
//             : Colors.grey[200];

//     final textColor = isPrompt
//         ? Colors.white
//         : isDarkMode
//             ? Colors.white
//             : Colors.black;

//     return Row(
//       mainAxisAlignment:
//           isPrompt ? MainAxisAlignment.end : MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         // User avatar for bot messages
//         if (!isPrompt)
//           CircleAvatar(
//             radius: 16,
//             backgroundColor: Colors.grey[300],
//             child: Icon(Icons.assistant, size: 20, color: Colors.grey[700]),
//           ),
    
//         const SizedBox(width: ASizes.sm),
    
//         // Message bubble
//         Flexible(
//           child: Container(
//             constraints: BoxConstraints(
//               maxWidth: MediaQuery.of(context).size.width * 0.75,
//               minHeight: 40,
//             ),
//             padding: const EdgeInsets.symmetric(
//                 horizontal: ASizes.md, vertical: ASizes.sm),
//             decoration: BoxDecoration(
//               color: bubbleColor,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(20),
//                 topRight: Radius.circular(20),
//                 bottomLeft: Radius.circular(isPrompt ? 20 : 5),
//                 bottomRight: Radius.circular(isPrompt ? 5 : 20),
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withValues(alpha: 0.05),
//                   blurRadius: 5,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SelectableText(
//                   message,
//                   style: TextStyle(fontSize: 16, color: textColor),
//                 ),
//                 const SizedBox(height: ASizes.xs),
//                 Text(
//                   date,
//                   style: TextStyle(
//                     fontSize: 11,
//                     color: textColor.withValues(alpha: 0.6),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
    
//         const SizedBox(width: ASizes.sm),
    
//         // User avatar for user messages
//         if (isPrompt)
//           CircleAvatar(
//             radius: 16,
//             backgroundColor: Colors.blue[100],
//             child: const Icon(Icons.person, size: 20, color: Colors.blue),
//           ),
//       ],
//     );
//   }
// }
