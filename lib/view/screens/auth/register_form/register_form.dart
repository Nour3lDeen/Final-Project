import 'package:final_project/view/common_components/custom_text_form_field/custom_text_form_field.dart';
import 'package:final_project/view_model/cubits/auth/auth_cubit.dart';
import 'package:final_project/view_model/utils/navigation/navigation.dart';
import 'package:final_project/view_model/utils/texts/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../view_model/utils/app_assets/app_assets.dart';
import '../../../../view_model/utils/app_colors/app_colors.dart';
import '../../main/main_screen.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final authCubit = AuthCubit.get(context);
        return Padding(
          padding: EdgeInsets.only(top: 24.h),
          child: Form(
            key: authCubit.registerFormKey,
            child: SingleChildScrollView(
              clipBehavior: Clip.none,
              child: Column(
                spacing: 16.h,
                children: [
                  Row(
                    spacing: 8.w,
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          title: 'First Name',
                          titleColor: HexColor('#1B1F1E'),
                          controller: authCubit.firstNameController,
                          keyboardType: TextInputType.emailAddress,
                          hint: 'Enter your First Name',
                          textInputAction: TextInputAction.next,
                          isPassword: false,
                          onIconTap: () {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your first name';
                            }
                            return null;
                          },
                          suffixIcon: const Icon(Icons.email),
                          obscureText: false,
                        ),
                      ),
                      Expanded(
                        child: CustomTextFormField(
                          title: 'Second Name',
                          titleColor: HexColor('#1B1F1E'),
                          controller: authCubit.secondNameController,
                          keyboardType: TextInputType.emailAddress,
                          hint: 'Enter your Second Name',
                          textInputAction: TextInputAction.next,
                          isPassword: false,
                          onIconTap: () {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your second name';
                            }
                            return null;
                          },
                          suffixIcon: const Icon(Icons.email),
                          obscureText: false,
                        ),
                      ),
                    ],
                  ),
                  CustomTextFormField(
                    title: 'Email',
                    titleColor: HexColor('#1B1F1E'),
                    controller: AuthCubit.get(context).registerEmailController,
                    keyboardType: TextInputType.emailAddress,
                    hint: 'Enter your Email',
                    textInputAction: TextInputAction.next,
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
                  CustomTextFormField(
                    title: 'Phone',
                    titleColor: HexColor('#1B1F1E'),
                    controller: AuthCubit.get(context).registerPhoneController,
                    keyboardType: TextInputType.phone,
                    hint: 'Enter your Phone',
                    textInputAction: TextInputAction.next,
                    isPassword: false,
                    onIconTap: () {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Phone';
                      }
                      return null;
                    },
                    suffixIcon: const Icon(Icons.phone),
                    obscureText: false,
                  ),
                  CustomTextFormField(
                    controller:
                        AuthCubit.get(context).registerPasswordController,
                    title: 'Password',
                    titleColor: HexColor('#1B1F1E'),
                    keyboardType: TextInputType.visiblePassword,
                    hint: 'Password',
                    textInputAction: TextInputAction.next,
                    isPassword: true,
                    onIconTap: () {
                      AuthCubit.get(context).changePasswordVisibility();
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    suffixIcon: Icon(AuthCubit.get(context).showPassword
                        ? Icons.visibility_off
                        : Icons.visibility),
                    obscureText: AuthCubit.get(context).showPassword,
                  ),
                  CustomTextFormField(
                    controller: AuthCubit.get(context)
                        .registerConfirmPasswordController,
                    title: 'Confirm Password',
                    titleColor: HexColor('#1B1F1E'),
                    keyboardType: TextInputType.visiblePassword,
                    hint: 'Confirm your Password',
                    textInputAction: TextInputAction.done,
                    isPassword: true,
                    onIconTap: () {
                      AuthCubit.get(context).changePasswordVisibility();
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please confirm your password';
                      }
                      return null;
                    },
                    suffixIcon: Icon(AuthCubit.get(context).showPassword
                        ? Icons.visibility_off
                        : Icons.visibility),
                    obscureText: AuthCubit.get(context).showPassword,
                  ),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      final authCubit = AuthCubit.get(context);
                      if (state is RegisterSuccessState) {
                        authCubit.viewToast(
                          'Registration successful!',
                          context,
                          AppColors.primaryColor,
                          2,
                        );
                        Navigation.pushAndRemove(context, MainScreen());
                      }
                      if (state is RegisterErrorState) {
                        authCubit.viewToast(
                          state.msg ,
                          context,
                          AppColors.red,
                          2,
                        );
                      }
                    },
                    buildWhen: (previous, current) {
                      return (current is RegisterLoadingState) ||
                          (previous is RegisterLoadingState &&
                              current is! RegisterLoadingState);
                    },
                    builder: (context, state) {
                      final authCubit = AuthCubit.get(context);
                      return InkWell(
                        borderRadius: BorderRadius.circular(10.r),
                        onTap: () {
                          if (state is! RegisterLoadingState &&
                              authCubit.registerFormKey.currentState!
                                  .validate()) {
                            authCubit.register();
                          }
                        },
                        child: state is RegisterLoadingState
                            ? SizedBox(
                                width: 20.w,
                                height: 20.h,
                                child: CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                  strokeWidth: 2,
                                ),
                              )
                            : Container(
                                width: double.infinity,
                                height: 36.h,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.black
                                          .withValues(alpha: 0.15),
                                      offset: Offset(1.w, 2.h),
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                  color: state is RegisterLoadingState
                                      ? AppColors.primaryColor.withValues(alpha: 0.7)
                                      : AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Center(
                                  child: TextBody14(
                                    'Sign Up',
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                      );
                    },
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
          ),
        );
      },
    );
  }
}
/*Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextTitle(
              "Explore the app",
              fontSize: 30.sp,
              color: AppColors.secondaryColor,
            ),
            SizedBox(
              height: 100.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 12.h,
              ),
              child: CustomButton(
                borderRadius: 10.r,
                onPressed: () {
                  Navigation.pushAndRemove(context, LoginScreen());
                },
                child: SizedBox(
                    width: double.infinity,
                    height: 40.h,
                    child: Center(
                        child: TextTitle(
                      "Login",
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 8.h,
              ),
              child: CustomButton(
                backgroundColor: AppColors.white,
                borderRadius: 10.r,
                onPressed: () {
                  Navigation.push(context, const SignUp());
                },
                child: Container(
                    width: double.infinity,
                    height: 40.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: 1,
                        )),
                    child: Center(
                        child: TextTitle(
                      "Sign Up",
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ))),
              ),
            ),
            InkWell(
              onTap: () {},
              child: TextBody14(
                "Guest",
                fontWeight: FontWeight.w600,

                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(
              height: 30.h,
            )
          ],
        ),
      ),*/
