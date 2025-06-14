part of 'chat_bot_cubit.dart';

@immutable
sealed class ChatbotState {}

class ChatbotInitial extends ChatbotState {}

class ChatbotUpdated extends ChatbotState {}
class ScrollToBottom extends ChatbotState {}
