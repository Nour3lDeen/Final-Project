import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:final_project/view_model/utils/Texts/Texts.dart';
import 'package:final_project/view_model/utils/app_assets/app_assets.dart';
import 'package:final_project/view_model/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../view_model/cubits/chat_bot/chat_bot_cubit.dart';
import 'components/chat_bubble.dart';
import 'components/message_input_field.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  @override
  void initState() {
    super.initState();
    final cubit = ChatbotCubit.get(context);
    cubit.scrollController ??= ScrollController();
    cubit.scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        centerTitle: true,
        leading: const SizedBox(),
        title: TextBody14(
          'Abu Qerdan',
          fontSize: 16.sp,
          color: AppColors.white,
        ),
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatbotCubit, ChatbotState>(
              builder: (context, state) {
                final chatCubit = ChatbotCubit.get(context);
                final messages = chatCubit.messages;
                if (messages.isEmpty) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedTextKit(
                            animatedTexts: [
                              TypewriterAnimatedText(
                                'Start chatting with me!',
                                textStyle: TextStyle(
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                speed: const Duration(milliseconds: 150),
                              ),
                            ],
                    
                            totalRepeatCount: 100,
                            pause: const Duration(milliseconds: 500),
                        ),
                        Image.asset(AppAssets.egret,height: 350.h,)
                      ],
                    ),
                  );
                } else {
                  return ListView.builder(
                    controller: chatCubit.scrollController,
                    padding: EdgeInsets.all(16.sp),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return ChatBubble(
                        message: message.text,
                        isUser: message.isUser,
                      );
                    },
                  );
                }
              },
            ),
          ),
          const MessageInputField(),
        ],
      ),
    );
  }
}
