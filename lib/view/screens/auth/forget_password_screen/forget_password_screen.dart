import 'package:final_project/view/screens/auth/otp_screen/otp_screen.dart';
import 'package:final_project/view_model/cubits/auth/auth_cubit.dart';
import 'package:final_project/view_model/utils/Texts/Texts.dart';
import 'package:final_project/view_model/utils/app_assets/app_assets.dart';
import 'package:final_project/view_model/utils/app_colors/app_colors.dart';
import 'package:final_project/view_model/utils/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../common_components/custom_text_form_field/custom_text_form_field.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final authCubit = AuthCubit.get(context);
        return Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.white,
            ),
            padding: EdgeInsets.only(right: 16.w, left: 16.w, top: 80.h),
            child: Form(
              key: authCubit.forgetPasswordFormKey,
              child: Column(
                spacing: 12.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Image.asset(AppAssets.forgotPassword)),
                  TextTitle(
                    'Forgot password?',
                    fontSize: 22.sp,
                    color: HexColor('#374151'),
                  ),
                  const TextBody14('Enter your registered email below'),
                  CustomTextFormField(
                    title: 'Email',
                    titleColor: HexColor('#1B1F1E'),
                    controller: authCubit.forgetPasswordEmailController,
                    keyboardType: TextInputType.emailAddress,
                    hint: 'Enter your Email',
                    isPassword: false,
                    onIconTap: () {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    suffixIcon: const Icon(Icons.email),
                    obscureText: false,
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(10.r),
                    onTap: () {
                      if (authCubit.forgetPasswordFormKey.currentState!
                          .validate()) {
                        Navigation.push(context, const OtpScreen());
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 36.h,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.black.withValues(alpha: 0.15),
                              offset: Offset(1.w, 2.h),
                              blurRadius: 6.0)
                        ],
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Center(
                        child: TextBody14(
                          'Send',
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
