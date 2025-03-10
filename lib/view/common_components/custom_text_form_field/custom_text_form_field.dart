import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../view_model/utils/app_colors/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.title,
      required this.hint,
      required this.titleColor,
      required this.isPassword,
      required this.controller,
      required this.onIconTap,
      required this.suffixIcon,
      required this.obscureText,
      this.keyboardType,
      this.validator,
      this.onTap,
      this.readOnly,
      this.textInputAction});

  final String title;
  final Color titleColor;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool isPassword;
  final bool obscureText;
  final String hint;
  final void Function() onIconTap;
  final void Function()? onTap;
  final TextEditingController controller;
  final Icon suffixIcon;
  final bool? readOnly;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      textInputAction: textInputAction ?? TextInputAction.next,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      cursorColor: AppColors.primaryColor,
      onTap: onTap,
      readOnly: readOnly ?? false,
      keyboardType: keyboardType,
      obscureText: obscureText,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        suffixIcon: isPassword
            ? IconButton(
                icon: suffixIcon,
                onPressed: () {
                  onIconTap();
                },
              )
            : null,
        label: Text(title, style: TextStyle(color: titleColor)),
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 10.sp,
          color: AppColors.grey,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        fillColor: AppColors.white.withValues(alpha: 0.4),
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
            borderSide: BorderSide(color: HexColor('#DEDEDE'))),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
            borderSide: BorderSide(color: HexColor('#DEDEDE'))),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
            borderSide: BorderSide(color: HexColor('#DEDEDE'))),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
            borderSide: BorderSide(color: HexColor('#DEDEDE'))),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
            borderSide: BorderSide(color: HexColor('#DEDEDE'))),
      ),
      textDirection: TextDirection.ltr,
    );
  }
}
