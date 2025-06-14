import 'package:final_project/view_model/cubits/product/product_cubit.dart';
import 'package:final_project/view_model/utils/Texts/Texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../view_model/utils/app_colors/app_colors.dart';
import '../../../view_model/utils/navigation/navigation.dart';
import '../categories/components/favorite_component.dart';
import '../categories/product_details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        final cubit = context.read<ProductCubit>();
        return Scaffold(
          appBar: AppBar(
            title: TextBody14(
              'Favorites',
              color: AppColors.white,
              fontSize: 18.sp,
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: AppColors.primaryColor,
            centerTitle: true,
          ),
          body: _buildBody(cubit, state,context),
        );
      },
    );
  }

  Widget _buildBody(ProductCubit cubit, ProductState state, BuildContext context) {
    if (state is GetFavoritesLoadingState) {
      return Center(
        child: CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
      );
    } else {
      return cubit.favorites.isEmpty
          ? Center(
        child: TextBody14(
          'No favorites yet 🌿',
          fontSize: 18.sp,
        ),
      )
          : SingleChildScrollView(
        padding: EdgeInsets.all(16.sp),
        child: Wrap(
          spacing: 16.w,
          runSpacing: 16.h,
          children: ProductCubit.get(context)
              .favorites
              .map((product) {
            return Container(
              width: (MediaQuery.of(context).size.width - 48.w) / 2,
              //height: 250.h,

              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                elevation: 4,
                shadowColor: Colors.black.withValues(alpha: 0.4),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Image.network(
                          product.pictureUrl ?? '',
                          height: 120.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              height: 120.h,
                              width: double.infinity,

                              color: Colors.grey[100],
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                  strokeWidth: 2,
                                ),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) => Container(
                            height: 120.h,
                            width: double.infinity,
                            color: Colors.grey[100],
                            child: Icon(
                              Icons.image_not_supported,
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                        // Favorite Button
                        PositionedDirectional(
                          top: 8.h,
                          end: 0.w,
                          child: FavoriteComponent(
                            big: false,
                            productId: product.id ?? 0,
                          ),
                        ),
                      ],
                    ),
                    // Product Details
                    Padding(
                      padding: EdgeInsets.all(12.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            product.name ?? 'Product Name',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              height: 1.3,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 6.h),
                          // Price
                          Text(
                            '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                              color: AppColors.primaryColor,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          // Add to Cart Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                elevation: 0,
                              ),
                              onPressed: () {
                                // Add to cart logic
                              },
                              child: TextBody12(
                                'Add to Cart',
                                fontSize: 12.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      );
    }
  }
}