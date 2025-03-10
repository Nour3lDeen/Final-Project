import 'package:final_project/view/screens/auth/register_form/register_form.dart';
import 'package:final_project/view_model/utils/app_assets/app_assets.dart';
import 'package:final_project/view_model/utils/app_colors/app_colors.dart';
import 'package:final_project/view_model/utils/texts/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../view_model/cubits/auth_cubit.dart';
import '../login_form/login_form.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(),
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              final authCubit = AuthCubit.get(context);
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200.h,
                    padding:
                        EdgeInsets.only(right: 16.w, left: 16.w, top: 50.h),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          AppAssets.background,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          AppAssets.logo,
                          width: 160.w,
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        TextTitle(
                          authCubit.currentIndex == 0
                              ? 'Login in to your\nAccount'
                              : 'Create an\nAccount',
                          color: AppColors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        TextDescription(
                          authCubit.currentIndex == 0
                              ? 'Enter your email and password to log in '
                              : 'Create an account or log in to explore about our app',
                          color: AppColors.white,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 12.sp,
                        ),
                      ],
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(0, -12.h),
                    child: Container(
                      width: double.infinity,
                      height: 490.h,
                      clipBehavior: Clip.none,
                      padding:
                          EdgeInsets.only(right: 16.w, left: 16.w, top: 16.h),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.r),
                          topRight: Radius.circular(16.r),
                        ),
                      ),
                      child: DefaultTabController(
                        length: 2,
                        initialIndex: authCubit.currentIndex,
                        child: Column(
                          children: [
                            Container(
                              clipBehavior: Clip.none,
                              width: double.infinity,
                              padding: EdgeInsets.only(top: 4.h, bottom: 4.h),
                              decoration: BoxDecoration(
                                color: HexColor('EDEDED'),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: TabBar(
                                onTap: (index) {
                                  authCubit.changeTab(index);
                                },
                                labelColor: AppColors.black,
                                unselectedLabelColor: HexColor('#7D7D91'),
                                indicatorColor: Colors.transparent,
                                dividerColor: Colors.transparent,
                                tabs: [
                                  Container(
                                      height: 25.h,
                                      decoration: BoxDecoration(
                                        color: authCubit.currentIndex == 0
                                            ? AppColors.white
                                            : Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                      child: Center(
                                          child: TextBody14(
                                        'Login',
                                      ))),
                                  Container(
                                      height: 25.h,
                                      decoration: BoxDecoration(
                                        color: authCubit.currentIndex == 1
                                            ? AppColors.white
                                            : Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                      child: Center(
                                          child: TextBody14(
                                        'Sign Up',
                                      ))),
                                ],
                              ),
                            ),
                            Expanded(
                              child: TabBarView(
                                physics: NeverScrollableScrollPhysics(),
                                children: [LoginForm(), RegisterForm()],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ));
  }
}
