import 'package:final_project/view/common_components/custom_text_form_field/custom_text_form_field.dart';
import 'package:final_project/view_model/cubits/auth_cubit.dart';
import 'package:final_project/view_model/utils/texts/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../view_model/utils/app_assets/app_assets.dart';
import '../../../../view_model/utils/app_colors/app_colors.dart';
import '../../../../view_model/utils/navigation/navigation.dart';
import '../forget_password_screen/forget_password_screen.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final authCubit = AuthCubit.get(context);
        return Padding(
          padding: EdgeInsets.only(top: 24.h),
          child: Form(
            key: authCubit.loginFormKey,
            child: Column(
              spacing: 16.h,
              children: [
                CustomTextFormField(
                  title: 'Email',
                  titleColor: HexColor('#1B1F1E'),
                  controller: authCubit.loginEmailController,
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
                  suffixIcon: Icon(Icons.email),
                  obscureText: false,
                ),
                CustomTextFormField(
                  controller: authCubit.loginPasswordController,
                  title: 'Password',
                  titleColor: HexColor('#1B1F1E'),
                  keyboardType: TextInputType.visiblePassword,
                  hint: 'Enter your Password',
                  isPassword: true,
                  onIconTap: () {
                    authCubit.changePasswordVisibility();
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  suffixIcon: Icon(authCubit.showPassword
                      ? Icons.visibility_off
                      : Icons.visibility),
                  obscureText: authCubit.showPassword,
                ),
                Row(
                  children: [
                    Transform.scale(
                      scale: 1,
                      child: SizedBox(
                        width: 16.w,
                        child: Checkbox(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            value: authCubit.rememberMe,
                            onChanged: (value) {
                              authCubit.changeRememberMe();
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            activeColor: AppColors.primaryColor,
                            checkColor: AppColors.white,
                            side: BorderSide(
                              color: AppColors.black.withValues(alpha: 0.6),
                            )),
                      ),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    TextBody12(
                      'Remember me',
                      color: AppColors.black.withValues(alpha: 0.6),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        Navigation.push(context, const ForgetPassword());
                      },
                      style: const ButtonStyle(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: TextBody12(
                        'Forgot Password?',
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(10.r),
                  onTap: () {
                    authCubit.loginFormKey.currentState!.validate();
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
                        'Login',
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: HexColor('#DEDEDE'),
                      ),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    TextBody12(
                      'Or',
                      color: AppColors.grey,
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: HexColor('#DEDEDE'),
                      ),
                    ),
                  ],
                ),
                Center(
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
                      color: AppColors.white,
                      border: Border.all(color: HexColor('#DEDEDE')),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      spacing: 6.w,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(height: 18.h, AppAssets.google),
                        Center(
                          child: TextBody14('Continue with Google',
                              color: AppColors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
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
                      color: AppColors.white,
                      border: Border.all(color: HexColor('#DEDEDE')),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      spacing: 6.w,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(height: 18.h, AppAssets.facebook),
                        Center(
                          child: TextBody14('Continue with Facebook',
                              color: AppColors.black),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
