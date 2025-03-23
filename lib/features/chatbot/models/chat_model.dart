class ChatModel {
  final bool isPrompt;
  final String message;
  final DateTime time;

  ChatModel({
    required this.isPrompt,
    required this.message,
    required this.time,
  });
}
