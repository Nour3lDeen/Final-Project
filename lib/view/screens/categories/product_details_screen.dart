import 'package:defer_pointer/defer_pointer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/model/product/product_model.dart';
import 'package:final_project/view_model/cubits/auth/auth_cubit.dart';
import 'package:final_project/view_model/cubits/product/product_cubit.dart';
import 'package:final_project/view_model/utils/Texts/Texts.dart';
import 'package:final_project/view_model/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../view_model/utils/navigation/navigation.dart';
import 'cart/cart_screen.dart';
import 'components/favorite_component.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.8),
              shape: BoxShape.circle,
            ),
            child: Align(
                alignment: AlignmentDirectional.center,
                child: Icon(
                  Icons.arrow_back,
                  size: 20.w,
                  color: AppColors.black,
                )),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          FavoriteComponent(
            big: true,
            productId: product.id ?? 0,
          )
        ],
      ),
      body: Column(
        children: [
          // Product Image Gallery
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                PageView.builder(
                  itemCount: (product.morePicturesList?.length ?? 0) + 1,
                  itemBuilder: (context, index) {
                    final imageUrl = index == 0
                        ? product.pictureUrl
                        : product.morePicturesList?[index - 1];
                    return Image.network(
                      imageUrl ?? '',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[200],
                        child: Icon(Icons.image_not_supported,
                            size: 50.w, color: Colors.grey[400]),
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: 20.h,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      (product.morePicturesList?.length ?? 0) + 1,
                      (index) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        width: 8.w,
                        height: 8.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white
                              .withValues(alpha: index == 0 ? 0.9 : 0.4),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Product Details
          Expanded(
            flex: 6,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 20,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            product.name ?? 'No name available',
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              color: Colors.green[900],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: Colors.amber.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star,
                                  color: Colors.amber, size: 18.sp),
                              SizedBox(width: 4.w),
                              Text(
                                product.rate?.toStringAsFixed(1) ?? '0.0',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    // Category and Price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.typeName ?? 'Uncategorized',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: 'Poppins',
                            color: Colors.grey[600],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Text(
                          '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontFamily: 'Poppins',
                            color: Colors.green[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    // Description Section
                    Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.green[900],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      product.description ?? 'No description available',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontFamily: 'Poppins',
                        color: Colors.grey[700],
                        height: 1.6,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    // Add to Cart Button
                    Row(
                      children: [
                        BlocConsumer<ProductCubit, ProductState>(
                          listener: (context, state) {
                            if (state is AddToCartSuccessState) {
                              AuthCubit.get(context).viewToast(
                                'Added to Cart',
                                context,
                                AppColors.primaryColor,
                                2,
                              );
                            } else if (state is AddToCartErrorState) {
                              AuthCubit.get(context).viewToast(
                                state.msg,
                                context,
                                Colors.red,
                                2,
                              );
                            }
                          },
                          builder: (context, state) {
                            if (state is AddToCartLoadingState) {
                              return CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              );
                            } else {
                              return Expanded(
                                child: SizedBox(
                                  height: 50.h,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                      elevation: 3,
                                    ),
                                    onPressed: () {
                                      ProductCubit.get(context).quantity = 1;
                                      showGeneralDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        barrierLabel: 'Quantity',
                                        barrierColor:
                                            Colors.black.withValues(alpha: 0.5),
                                        transitionDuration:
                                            const Duration(milliseconds: 300),
                                        pageBuilder: (_, __, ___) {
                                          final cubit =
                                              ProductCubit.get(context);
                                          return BlocBuilder<ProductCubit,
                                              ProductState>(
                                            builder: (context, state) {
                                              return Center(
                                                child: Material(
                                                  color: Colors.transparent,
                                                  child: Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20.w),
                                                    padding:
                                                        EdgeInsets.all(20.r),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.r),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black
                                                              .withValues(
                                                                  alpha: 0.1),
                                                          blurRadius: 20,
                                                          spreadRadius: 5,
                                                        ),
                                                      ],
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          'Select Quantity',
                                                          style: TextStyle(
                                                            fontSize: 18.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black87,
                                                          ),
                                                        ),
                                                        SizedBox(height: 20.h),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            // Minus Button
                                                            GestureDetector(
                                                              onTap: cubit.quantity >
                                                                      1
                                                                  ? cubit
                                                                      .decrementQuantity
                                                                  : null,
                                                              child: Container(
                                                                width: 40.r,
                                                                height: 40.r,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: cubit.quantity >
                                                                          1
                                                                      ? AppColors
                                                                          .primaryColor
                                                                          .withValues(
                                                                              alpha:
                                                                                  0.1)
                                                                      : Colors
                                                                          .grey
                                                                          .withValues(
                                                                              alpha: 0.1),
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                                child: Icon(
                                                                  Icons.remove,
                                                                  color: cubit.quantity >
                                                                          1
                                                                      ? AppColors
                                                                          .primaryColor
                                                                      : Colors
                                                                          .grey,
                                                                  size: 20.r,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: 20.w),
                                                            BlocBuilder<
                                                                ProductCubit,
                                                                ProductState>(
                                                              builder: (context,
                                                                  state) {
                                                                return Container(
                                                                  width: 60.w,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .symmetric(
                                                                    vertical:
                                                                        10.h,
                                                                    horizontal:
                                                                        15.w,
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: AppColors
                                                                          .primaryColor
                                                                          .withValues(
                                                                              alpha: 0.3),
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.r),
                                                                  ),
                                                                  child: Text(
                                                                    '${ProductCubit.get(context).quantity}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          18.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                            SizedBox(
                                                                width: 20.w),
                                                            // Plus Button
                                                            GestureDetector(
                                                              onTap: cubit
                                                                  .incrementQuantity,
                                                              child: Container(
                                                                width: 40.r,
                                                                height: 40.r,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: AppColors
                                                                      .primaryColor
                                                                      .withValues(
                                                                          alpha:
                                                                              0.1),
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                                child: Icon(
                                                                  Icons.add,
                                                                  color: AppColors
                                                                      .primaryColor,
                                                                  size: 20.r,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 30.h),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child:
                                                                  OutlinedButton(
                                                                style: OutlinedButton
                                                                    .styleFrom(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          vertical:
                                                                              15.h),
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12.r),
                                                                  ),
                                                                  side:
                                                                      BorderSide(
                                                                    color: AppColors
                                                                        .primaryColor,
                                                                  ),
                                                                ),
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        context),
                                                                child: Text(
                                                                  'Cancel',
                                                                  style:
                                                                      TextStyle(
                                                                    color: AppColors
                                                                        .primaryColor,
                                                                    fontSize:
                                                                        16.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: 15.w),
                                                            Expanded(
                                                              child:
                                                                  ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  backgroundColor:
                                                                      AppColors
                                                                          .primaryColor,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12.r),
                                                                  ),
                                                                  elevation: 3,
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          vertical:
                                                                              15.h),
                                                                ),
                                                                onPressed: () {
                                                                  cubit
                                                                      .addToCart(
                                                                    productId:
                                                                        product.id ??
                                                                            0,
                                                                    quantity: cubit
                                                                        .quantity,
                                                                  );
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Text(
                                                                  'Add to Cart',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16.sp,
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        transitionBuilder:
                                            (_, anim, __, child) {
                                          return ScaleTransition(
                                            scale: CurvedAnimation(
                                              parent: anim,
                                              curve: Curves.easeOutBack,
                                            ),
                                            child: child,
                                          );
                                        },
                                      );
                                    },
                                    child: Text(
                                      'Add to Cart',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        Expanded(
                            child: SizedBox(
                          height: 50.h,
                          child: ElevatedButton(
                            onPressed: () {
                              ProductCubit.get(context).getCart();
                              Navigation.push(context, const CartScreen());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.greenAccent[400],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              elevation: 3,
                            ),
                            child: Text(
                              'View Cart',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
