import 'package:final_project/view_model/cubits/auth/auth_cubit.dart';
import 'package:final_project/view_model/utils/Texts/Texts.dart';
import 'package:final_project/view_model/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../common_components/custom_text_form_field/custom_text_form_field.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

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
              key: authCubit.otpFormKey,
              child: Column(
                spacing: 12.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextTitle(
                    'Reset Password',
                    fontSize: 22.sp,
                    color: HexColor('#374151'),
                  ),
                  const TextBody14('Code has been send to nourgemy54@gmail.com.'),
                  const TextBody14('Enter the code to reset your password.'),
                  CustomTextFormField(
                    title: 'Otp code',
                    titleColor: HexColor('#1B1F1E'),
                    controller: authCubit.otpController,
                    keyboardType: TextInputType.emailAddress,
                    hint: 'Enter the Otp code',
                    isPassword: false,
                    onIconTap: () {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the Otp code';
                      }
                      return null;
                    },
                    suffixIcon: const Icon(Icons.email),
                    obscureText: false,
                  ),
                  Row(
                    children: [
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          final cubit = AuthCubit.get(context);
                          final hours = (cubit.otpTimer ~/ 3600)
                              .toString()
                              .padLeft(2, '0');
                          final minutes = ((cubit.otpTimer % 3600) ~/ 60)
                              .toString()
                              .padLeft(2, '0');
                          final seconds =
                              (cubit.otpTimer % 60).toString().padLeft(2, '0');

                          return Column(
                            children: [
                              const TextBody12('Reset Timer in '),
                              TextBody12('$hours:$minutes:$seconds'),
                              // Display formatted time
                            ],
                          );
                        },
                      ),
                      const Spacer(),
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          final cubit = AuthCubit.get(context);
                          if (state is ResendOtpLoadingState) {
                            return CircularProgressIndicator.adaptive(
                              backgroundColor: AppColors.primaryColor,
                            );
                          } else {
                            return GestureDetector(
                              onTap: () {
                                if (cubit.canResendOtp) {
                                  cubit.startOtpTimer();
                                }
                              },
                              child: TextBody14(
                                'Resend Otp Code',
                                color: cubit.canResendOtp
                                    ? AppColors.primaryColor
                                    : AppColors.grey,
/*
                                shadows: [
                                  if (cubit.canResendOtp)
                                    BoxShadow(
                                      color: AppColors.black
                                          .withValues(alpha: 0.2),
                                      blurRadius: 5,
                                      offset: Offset(1.w, 1.h),
                                    )
                                ],
*/
                                fontSize: 12.sp,
                                textAlign: TextAlign.center,
                              ),
                            );
                          } // Hide button when timer is running
                        },
                      ),
                    ],
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(10.r),
                    onTap: () {
                      if (authCubit.otpFormKey.currentState!.validate()) {
                        if (authCubit.canResendOtp) {
                          authCubit.startOtpTimer();
                        }
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
