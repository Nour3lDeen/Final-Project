import 'package:final_project/model/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'chat_service.dart';

part 'chat_bot_state.dart';

class ChatbotCubit extends Cubit<ChatbotState> {
  static ChatbotCubit get(context) => BlocProvider.of<ChatbotCubit>(context);

  final ChatService _chatService = ChatService();

  // Store messages inside the cubit instead of in the state
  final List<ChatMessage> _messages = [];

  ScrollController? scrollController;
  final TextEditingController messageController = TextEditingController();

  List<ChatMessage> get messages => _messages;

  ChatbotCubit() : super(ChatbotInitial()) {
    scrollController = ScrollController();
  }

  Future<void> sendMessage(String message) async {
    // Add user message
    final userMessage = ChatMessage(text: message, isUser: true);
    _messages.add(userMessage);
    emit(ChatbotUpdated()); // emit a generic state

    try {
      final response = await _chatService.sendMessage(message);
      final botMessage = ChatMessage(text: response, isUser: false);
      _messages.add(botMessage);
    } catch (_) {
      _messages.add(ChatMessage(
        text: "Sorry, I'm having trouble responding. Please try again later.",
        isUser: false,
      ));
    }

    emit(ChatbotUpdated());
    scrollToBottom();
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController?.hasClients ?? false) {
        scrollController!.animateTo(
          scrollController!.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
    emit(ScrollToBottom());
  }
}
