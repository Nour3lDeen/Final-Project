import 'package:final_project/view_model/cubits/auth/auth_cubit.dart';
import 'package:final_project/view_model/utils/Texts/Texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../view_model/cubits/product/product_cubit.dart';
import '../../../../view_model/utils/app_colors/app_colors.dart';
import 'orders_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextBody14(
          'Checkout',
          color: AppColors.white,
          fontSize: 18.sp,
        ),
        backgroundColor: AppColors.primaryColor,
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
          {
            return Padding(
              padding: EdgeInsets.all(16.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextBody14(
                    'Order Summary',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 16.h),
                  ...ProductCubit.get(context)
                      .cartItem
                      .items!
                      .map((item) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextBody14(
                                    '${item.productName} (x${item.quantity})'),
                                TextBody14(
                                    '\$${(item.price! * item.quantity!).toStringAsFixed(2)}'),
                              ],
                            ),
                          )),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextBody14(
                        'Total:',
                        fontSize: 18.sp,
                      ),
                      TextBody14(
                        '\$${ProductCubit.get(context).cartItem.totalPrice?.toStringAsFixed(2) ?? '0.00'}',
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  SizedBox(height: 32.h),
                  BlocConsumer<ProductCubit, ProductState>(
                    listener: (context, state) {
                      if (state is CreateOrderSuccessState) {
                        AuthCubit.get(context).viewToast('Order Confirmed',
                            context, AppColors.primaryColor, 2);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const OrdersScreen(),
                            ));
                      } else if (state is CreateOrderErrorState) {
                        AuthCubit.get(context)
                            .viewToast(state.msg, context, Colors.red, 2);
                      }
                    },
                    builder: (context, state) {
                      if (state is CreateOrderLoadingState) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        );
                      } else {
                        return SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              backgroundColor: Colors.green,
                            ),
                            onPressed: () {
                              context.read<ProductCubit>().createOrder();
                              /* Navigator.popUntil(
                                  context, (route) => route.isFirst);*/
                            },
                            child: TextBody14(
                              'Confirm Order',
                              color: AppColors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
