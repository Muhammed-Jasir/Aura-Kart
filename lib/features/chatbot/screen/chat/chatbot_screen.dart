// import 'package:aurakart/common/widgets/appbar/appbar.dart';
// import 'package:aurakart/features/chatbot/controller/chatbot_controller.dart';
// import 'package:aurakart/features/chatbot/screen/chat/widgets/chat_bubble.dart';
// import 'package:aurakart/features/chatbot/screen/chat/widgets/chat_input_field.dart';
// import 'package:aurakart/utils/constants/sizes.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:aurakart/utils/constants/image_strings.dart';

// class ChatbotScreen extends StatelessWidget {
//   const ChatbotScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final chatController = Get.put(ChatBotController());

//     return Scaffold(
//       appBar: AAppBar(
//         title: const Text("Dekozy Chatbot"),
//         showBackArrow: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.info_outline),
//             onPressed: () {
//               // Show info about chatbot
//               Get.dialog(
//                 AlertDialog(
//                   title: const Text("About Dekozy Chatbot"),
//                   content: const Text(
//                       "I'm here to help you with product information and shopping assistance."),
//                   actions: [
//                     TextButton(
//                       onPressed: () => Get.back(),
//                       child: const Text("OK"),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           // Use BoxDecoration for the background image
//           image: DecorationImage(
//             image: AssetImage(AImages.chatImage),
//             fit: BoxFit.cover,
//             colorFilter: ColorFilter.mode(
//               Colors.black.withValues(alpha: 0.1),
//               BlendMode.darken,
//             ),
//           ),
//         ),
//         child: SafeArea(
//           child: Column(
//             children: [
//               // Chat Message Area
//               Expanded(
//                 child: Obx(
//                   () => ListView.builder(
//                     padding: const EdgeInsets.all(ASizes.md),
//                     reverse: true,
//                     shrinkWrap: true,
//                     itemCount: chatController.messages.length,
//                     itemBuilder: (context, index) {
//                       final message = chatController.messages[index];
//                       return ChatBubble(
//                         isPrompt: message.isPrompt,
//                         message: message.message,
//                         date: DateFormat('hh:mm a').format(message.time),
//                       );
//                     },
//                   ),
//                 ),
//               ),

//               // Input field at the bottom
//               ChatInputField(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
