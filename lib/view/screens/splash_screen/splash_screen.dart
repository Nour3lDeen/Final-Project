import 'package:final_project/view/screens/auth/welcome_screen/welcome_screen.dart';
import 'package:final_project/view/screens/main/main_screen.dart';
import 'package:final_project/view_model/cubits/auth/auth_cubit.dart';
import 'package:final_project/view_model/cubits/product/product_cubit.dart';
import 'package:final_project/view_model/utils/data/local/shared_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../view_model/utils/app_assets/app_assets.dart';
import '../../../view_model/utils/app_colors/app_colors.dart';
import '../../../view_model/utils/data/local/shared_keys.dart';
import '../../../view_model/utils/navigation/navigation.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (SharedHelper.getData(SharedKeys.isLogged) == true &&
          SharedHelper.getData(SharedKeys.token) != null) {
        AuthCubit.get(context).getUserData();
        AuthCubit.get(context).getUserAddress();
        ProductCubit.get(context).getCategories();
        ProductCubit.get(context).getAllProducts();
        ProductCubit.get(context).getFavorites();

        Navigation.pushAndRemove(context, MainScreen());
      } else {
        Navigation.pushAndRemove(context, const WelcomeScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(
          child: Image.asset(
            AppAssets.splash,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
