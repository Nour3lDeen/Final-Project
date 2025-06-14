import 'package:final_project/view_model/cubits/product/product_cubit.dart';
import 'package:final_project/view_model/utils/app_assets/app_assets.dart';
import 'package:final_project/view_model/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../view_model/cubits/nav/nav_cubit.dart';
import '../categories/categories_screen.dart';
import '../chat_bot/chat_bot_screen.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';
import '../scan/scan_screen.dart';

class MainScreen extends StatelessWidget {
  final List<Widget> _screens = [
    const HomeScreen(),
    CategoriesScreen(),
    const ScanScreen(),
    const ChatbotScreen(),
    const ProfileScreen(),
  ];

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavCubit(),
      child: BlocBuilder<NavCubit, int>(
        builder: (context, index) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white.withValues(alpha: 0.95),
              body: _screens[index],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: index,
                selectedItemColor: AppColors.primaryColor,
                unselectedItemColor: Colors.grey,
                backgroundColor: Colors.white,
                onTap: (i) {
                  if (i != index &&
                      i == 1 &&
                      ProductCubit.get(context).categories.isEmpty) {
                    ProductCubit.get(context).getCategories();
                  }
                  if (i != index &&
                      i == 0 &&
                      ProductCubit.get(context).products.isEmpty) {
                    ProductCubit.get(context).getAllProducts();
                  }
                  context.read<NavCubit>().selectTab(i);
                },
                items: [
                  const BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Home'),
                  const BottomNavigationBarItem(
                      icon: Icon(Icons.local_florist), label: 'Categories'),
                  const BottomNavigationBarItem(
                      icon: Icon(Icons.qr_code_scanner), label: 'Scan'),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        AppAssets.chatbot,
                        height: 24.h,
                        colorFilter: ColorFilter.mode(
                            NavCubit.get(context).currentIndex == 3
                                ? AppColors.primaryColor
                                : Colors.grey,
                            BlendMode.srcIn),
                      ),
                      label: 'Abu Qerdan'),
                  // ✅ Updated Icon + Label
                  const BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: 'Profile'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
