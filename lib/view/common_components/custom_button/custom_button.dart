import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../view_model/utils/app_colors/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    required this.child,
    this.backgroundColor,
    this.elevationColor,
    this.elevation,
    this.borderRadius,
  });

  final void Function()? onPressed;
  final Widget child;
  final Color? backgroundColor;
  final Color? elevationColor;
  final double? elevation;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return  Material(
      borderRadius: BorderRadius.circular(borderRadius ?? 25.r),
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius ?? 25.r),
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
              color: backgroundColor??AppColors.primaryColor,
              borderRadius: BorderRadius.circular(borderRadius ?? 25.r),
          ),
          child: child,
        ),
      ),
    );
  }

}




class CustomTextField extends StatelessWidget {
  final String label;
  final String placeholder;
  final TextInputType keyboardType;
  final bool obscureText;
  final VoidCallback? onVisibilityToggle;
  final TextEditingController? controller;

  const CustomTextField({super.key,
    required this.label,
    required this.placeholder,
    required this.keyboardType,
    this.obscureText = false,
    this.onVisibilityToggle,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: 45,
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: placeholder,
          suffixIcon: onVisibilityToggle != null
              ? IconButton(
            icon: Icon(
              obscureText ? Icons.visibility_off : Icons.visibility,
              color: Colors.teal,
            ),
            onPressed: onVisibilityToggle,
          )
              : null,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.teal,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

/*class CustomTextField extends StatelessWidget {
  final String label;
  final String placeholder;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData? leadingIcon;

  CustomTextField({
    required this.label,
    required this.placeholder,
    required this.keyboardType,
    this.obscureText = false, // خاصية إخفاء النص
    this.leadingIcon, // أيقونة اختيارية
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: leadingIcon != null ? Icon(leadingIcon) : null,
        hintText: placeholder,
        labelText: label,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.teal,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
*/