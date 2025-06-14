import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project/view/screens/categories/product_details_screen.dart';
import 'package:final_project/view_model/utils/Texts/Texts.dart';
import 'package:final_project/view_model/utils/app_assets/app_assets.dart';
import 'package:final_project/view_model/utils/app_colors/app_colors.dart';
import 'package:final_project/view_model/utils/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../view_model/cubits/nav/nav_cubit.dart';
import '../../../view_model/cubits/product/product_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🌿 Welcome Section
          TextBody14(
            '👋 Hello Green Lover!',
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
          SizedBox(height: 10.h),
          TextBody14(
            'Discover, scan, and talk to your smart plant assistant 🌱',
            fontSize: 16.sp,
            color: Colors.grey[700],
          ),

          SizedBox(height: 30.h),

          // 🛍 Product Previews
          TextBody14('🌼 Featured Plants',
              color: AppColors.secondaryColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold),
          SizedBox(height: 10.h),
          BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              return SizedBox(
                height: 180.h,
                child: ListView(
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                      ProductCubit.get(context).products.length > 5
                          ? 5
                          : ProductCubit.get(context).products.length, (index) {
                    return Skeletonizer(
                      enabled: state is ProductLoadingState,
                      child: InkWell(
                        onTap: () {
                          Navigation.push(
                              context,
                              ProductDetailsScreen(
                                product:
                                    ProductCubit.get(context).products[index],
                              ));
                        },
                        borderRadius: BorderRadius.circular(16.r),
                        child: Container(
                          width: 140.w,
                          margin: EdgeInsets.only(right: 12.w),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black.withValues(alpha: 0.4),
                                offset: Offset(1.w, 3.h),
                                blurRadius: 6.0,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(16.r),
                            color: Colors.green[50],
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  ProductCubit.get(context)
                                          .products[index]
                                          .pictureUrl ??
                                      ''),
                              // add 3 plant images
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            padding: EdgeInsets.all(8.sp),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              gradient: const LinearGradient(
                                colors: [Colors.transparent, Colors.black26],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: TextBody14(
                              ProductCubit.get(context).products[index].name ??
                                  '',
                              fontSize: 14.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              );
            },
          ),

          SizedBox(height: 30.h),

          // 🔄 Navigation Preview
          TextBody14('✨ Explore More',
              color: AppColors.secondaryColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold),
          SizedBox(height: 10.h),

          Column(
            children: [
              _navTile(context, 'Categories', Icons.local_florist, 1,
                  'Browse all plant types and categories.'),
              _navTile(context, 'Scan', Icons.qr_code_scanner, 2,
                  'Scan plant diseases and get instant tips.'),
              _navTile(context, 'Abu Qerdan', Icons.chat_bubble, 3,
                  'Chat with your smart garden assistant.'),
              _navTile(context, 'Profile', Icons.person, 4,
                  'View your profile, history, and settings.'),
            ],
          )
        ],
      ),
    );
  }

  Widget _navTile(BuildContext context, String title, IconData icon, int index,
      String subtitle) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            offset: Offset(2.w, 4.h),
            blurRadius: 8,
          ),
        ],
      ),
      child: ListTile(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        leading: CircleAvatar(
          backgroundColor: AppColors.primaryColor.withValues(alpha: 0.1),
          child: index != 3
              ? Icon(icon, color: AppColors.primaryColor)
              : SvgPicture.asset(
                  AppAssets.chatbot,
                  height: 24.h,
                  colorFilter:
                      ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                ),
        ),
        title: TextBody14(title, fontSize: 16.sp, fontWeight: FontWeight.w600),
        subtitle: TextBody14(subtitle, fontSize: 12.sp, color: Colors.grey),
        trailing: Icon(Icons.arrow_forward_ios, size: 16.sp),
        onTap: () {
          if (index == 1 && ProductCubit.get(context).categories.isEmpty) {
            ProductCubit.get(context).getCategories();
          }
          ProductCubit.get(context).getFavorites();

          NavCubit.get(context).selectTab(index);
        },
      ),
    );
  }
}
