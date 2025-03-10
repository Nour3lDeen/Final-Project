import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../../view_model/utils/app_colors/app_colors.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon(
      {super.key,
      required this.onPressed,
      required this.size,
      required this.color,
      required this.icon,
      required this.containerColor,
      this.borderWidth,
      this.borderColor,
      this.borderRadius, required this.width, required this.height});

  final double size;
  final void Function() onPressed;
  final Color color;

  final IconData icon;

  final Color containerColor;

  final double? borderWidth;
  final double width;
  final double height;
  final double? borderRadius;

  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
      color: AppColors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
        onTap: onPressed,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: containerColor,
            border: Border.all(
              color: borderColor?? HexColor('#D8DADC'),
              width: borderWidth ?? 1,
            ),
            borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
          ),
          child: Icon(
              icon,
              size: size,
              color: color,
            ),

        ),
      ),
    );
  }
}
