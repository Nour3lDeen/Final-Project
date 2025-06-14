import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../view_model/cubits/chat_bot/chat_bot_cubit.dart';
import '../../../../view_model/utils/app_colors/app_colors.dart';

class MessageInputField extends StatelessWidget {

  const MessageInputField({super.key,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.sp),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              controller: ChatbotCubit.get(context).messageController,
              decoration: InputDecoration(
                hintText: 'Ask about your plants...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.r),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Container(
            decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
              BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.15),
                  offset: Offset(1.w, 2.h),
                  blurRadius: 6.0)
            ]),
            child: CircleAvatar(
              backgroundColor: AppColors.primaryColor,
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white),
                onPressed: () {
                  if (ChatbotCubit.get(context).messageController.text.trim().isNotEmpty) {
                    ChatbotCubit.get(context).sendMessage(ChatbotCubit.get(context).messageController.text);
                    ChatbotCubit.get(context).scrollToBottom();
                    debugPrint(ChatbotCubit.get(context).messageController.text);
                    ChatbotCubit.get(context).messageController.clear();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
