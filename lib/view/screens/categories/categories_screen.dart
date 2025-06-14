import 'package:final_project/view_model/cubits/product/product_cubit.dart';
import 'package:final_project/view_model/utils/Texts/Texts.dart';
import 'package:final_project/view_model/utils/app_colors/app_colors.dart';
import 'package:final_project/view_model/utils/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'category_details_screen.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
final productCubit = ProductCubit.get(context);
return ListView.builder(
          padding: EdgeInsets.all(16.sp),
          itemCount: productCubit.categories.length,
          itemBuilder: (context, index) {
            final category = productCubit.categories[index];
            return GestureDetector(
              onTap: () {
                Navigation.push(
                  context,
                  CategoryDetailsScreen(
                    category: category,
                  ),
                );
              },
              child: Skeletonizer(
                enabled: state is CategoryLoadingState,
                child: Container(
                  height: 130.h,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius
                            .circular(16)
                            .r),
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 10.h),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius:
                          BorderRadius.horizontal(left: Radius.circular(16.r)),
                          child: Image.network(
                            category.pictureUrl??'',
                            height: double.infinity,
                            width: 80.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextBody14(category.name??'' ,
                                    color: AppColors.secondaryColor,
                                    fontSize: 14.sp, fontWeight: FontWeight.w600),
                                SizedBox(height: 8.h),
                                TextBody14(category.description??'',
                                    color: Colors.grey[600],
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.normal),
                              ],
                            ),
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios, size: 16.sp),
                        SizedBox(width: 12.w),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
