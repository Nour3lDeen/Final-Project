import 'package:final_project/view/screens/auth/welcome_screen/welcome_screen.dart';
import 'package:final_project/view/screens/splash_screen/splash_screen.dart';
import 'package:final_project/view_model/cubits/auth/auth_cubit.dart';
import 'package:final_project/view_model/cubits/chat_bot/chat_bot_cubit.dart';
import 'package:final_project/view_model/cubits/nav/nav_cubit.dart';
import 'package:final_project/view_model/cubits/product/product_cubit.dart';
import 'package:final_project/view_model/cubits/reminder/reminder_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // ignore: avoid_redundant_argument_values
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => AuthCubit()),
            BlocProvider(create: (context) => NavCubit()),
            //BlocProvider(create: (context) => ReminderCubit()),
            BlocProvider(create: (context) => ChatbotCubit()),
            BlocProvider(create: (context) => ProductCubit()),
          ],
          child: MaterialApp(
            /*  localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,*/
            home: child,
            debugShowCheckedModeBanner: false,
          ),
        );
      },
      child: const SplashScreen(),
    );
  }
}
