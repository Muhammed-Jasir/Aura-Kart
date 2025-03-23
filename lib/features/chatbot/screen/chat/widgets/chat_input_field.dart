// import 'package:aurakart/utils/constants/colors.dart';
// import 'package:aurakart/utils/constants/sizes.dart';
// import 'package:aurakart/utils/helpers/helper_functions.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ChatInputField extends StatelessWidget {
//   const ChatInputField({super.key});

//   @override
//   Widget build(BuildContext context) {

//     final isDarkMode = AHelperFunctions.isDarkMode(context);

//     return Container(
//       padding: const EdgeInsets.symmetric(
//           horizontal: ASizes.sm, vertical: ASizes.sm),
//       decoration: BoxDecoration(
//         color: isDarkMode ? AColors.dark : AColors.light,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.1),
//             blurRadius: 10,
//             offset: Offset(0, -3),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               // controller: chatController.promptController,
//               style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
//               decoration: InputDecoration(
//                 hintText: "Type a message...",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25),
//                   borderSide: BorderSide.none,
//                 ),
//                 filled: true,
//                 fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
//                 contentPadding: const EdgeInsets.symmetric(
//                   horizontal: ASizes.md,
//                   vertical: ASizes.sm,
//                 ),
//               ),
//               minLines: 1,
//               maxLines: 5,
//               textCapitalization: TextCapitalization.sentences,
//               // onSubmitted: (_) => chatController.sendMessage(),
//             ),
//           ),

//           const SizedBox(width: ASizes.xs),

//           // Send Button
//           Obx(
//             () => AnimatedContainer(
//               duration: const Duration(milliseconds: 200),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 gradient: LinearGradient(
//                   colors: [Colors.blue, Colors.blue.shade700],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.blue.withValues(alpha: 0.3),
//                     blurRadius: 8,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Material(
//                 color: Colors.transparent,
//                 child: InkWell(
//                   // onTap: chatController.promptController.text.trim().isNotEmpty
//                   //     ? chatController.sendMessage
//                   //     : null,
//                   customBorder: const CircleBorder(),
//                   child: Padding(
//                     padding: EdgeInsets.all(ASizes.sm),
//                     child: Icon(
//                       Icons.send_rounded,
//                       color: Colors.white,
//                       size: 24,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
