import 'package:final_project/view_model/cubits/auth/auth_cubit.dart';
import 'package:final_project/view_model/cubits/product/product_cubit.dart';
import 'package:final_project/view_model/utils/Texts/Texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../model/product/cart_item.dart';
import '../../../../view_model/utils/app_colors/app_colors.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: TextBody14(
          'Your Cart',
          fontSize: 16.sp,
          color: AppColors.white,
        ),
        actions: [
          Visibility(
            // visible: ProductCubit.get(context).cartItem.items!.isEmpty,
            child: IconButton(
              icon: Icon(
                Icons.delete,
                color: AppColors.white,
              ),
              onPressed: () {
                // Show confirmation dialog before clearing cart
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Clear Cart'),
                    content: const Text(
                        'Are you sure you want to remove all items from your cart?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child:
                            TextBody14('Cancel', color: AppColors.primaryColor),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<ProductCubit>().clearCart();
                          Navigator.pop(context);
                        },
                        child: const TextBody14('Clear', color: Colors.red),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          final cart = ProductCubit.get(context).cartItem;

          if (state is GetCartLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (cart.items?.isEmpty ?? true) {
              return Center(
                child: TextBody14(
                  'Your cart is empty',
                  fontSize: 16.sp,
                  color: AppColors.secondaryColor,
                ),
              );
            } else {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cart.items!.length,
                      itemBuilder: (context, index) {
                        final item = cart.items![index];
                        return CartItemCard(
                          item: item,
                          onRemove: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Remove Item'),
                                content: const Text(
                                    'Are you sure you want to remove this item from your cart?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: TextBody14('Cancel',
                                        color: AppColors.primaryColor),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context
                                          .read<ProductCubit>()
                                          .removeFromCart(
                                              productId: item.productId ?? 0);
                                      AuthCubit.get(context).viewToast(
                                          'Item removed from cart',
                                          context,
                                          AppColors.red,
                                          2);
                                      Navigator.pop(context);
                                    },
                                    child: const TextBody14('Remove',
                                        color: Colors.red),
                                  ),
                                ],
                              ),
                            );
                          },
                          onIncrement: () {
                            context.read<ProductCubit>().updateQuantity(
                                  productId: item.productId ?? 0,
                                  operation: 'increment',
                                );
                          },
                          onDecrement: () {
                            if (item.quantity! > 1) {
                              context.read<ProductCubit>().updateQuantity(
                                    productId: item.productId ?? 0,
                                    operation: 'decrement',
                                  );
                            } else {
                              // Show confirmation dialog when trying to decrement to 0
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Remove Item'),
                                  content: const Text(
                                      'Are you sure you want to remove this item from your cart?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: TextBody14('Remove',
                                          color: AppColors.primaryColor),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        context
                                            .read<ProductCubit>()
                                            .removeFromCart(
                                                productId: item.productId ?? 0);
                                        AuthCubit.get(context).viewToast(
                                            'Item removed from cart',
                                            context,
                                            AppColors.red,
                                            2);
                                        Navigator.pop(context);
                                      },
                                      child: const TextBody14('Clear',
                                          color: Colors.red),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total:',
                                style: TextStyle(fontSize: 18)),
                            Text(
                              '\$${cart.totalPrice?.toStringAsFixed(2) ?? '0.00'}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              backgroundColor: AppColors.primaryColor,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CheckoutScreen(),
                                ),
                              );
                            },
                            child: TextBody14(
                              'Proceed to Checkout',
                              color: AppColors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          }
        },
      ),
    );
  },
);
  }
}

class CartItemCard extends StatelessWidget {
  final Items item;
  final VoidCallback onRemove;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CartItemCard({
    Key? key,
    required this.item,
    required this.onRemove,
    required this.onIncrement,
    required this.onDecrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Padding(
        padding: EdgeInsets.only(right: 12.h),
        child: Row(
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                item.pictureUrl ?? '',
                width: 100.w,
                height: 120.h,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 100.w,
                  height: 120.h,
                  color: Colors.grey[200],
                  child: const Icon(Icons.image),
                ),
              ),
            ),
            SizedBox(width: 16.w),
            // Product Details
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextBody14(
                      item.productName ?? 'Unknown Product',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 4.h),
                    TextBody14(
                      item.type ?? '',
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                    SizedBox(height: 8.h),
                    TextBody14(
                      '\$${((item.price ?? 0) * (item.quantity ?? 0)).toStringAsFixed(2)}',
                      fontSize: 16.sp,
                      color: AppColors.primaryColor,
                    ),
                  ],
                ),
              ),
            ),
            // Quantity Controls
            BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                return Skeletonizer(
                  enabled: state is UpdateQuantityLoadingState,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove, size: 20.r),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: onDecrement,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Text(
                            '${item.quantity}',
                            style: TextStyle(fontSize: 16.sp),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add, size: 20.r),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: onIncrement,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            // Remove Button
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onRemove,
            ),
          ],
        ),
      ),
    );
  }
}
