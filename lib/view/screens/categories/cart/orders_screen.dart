import 'package:final_project/model/product/orders_model.dart';
import 'package:final_project/view_model/cubits/product/product_cubit.dart';
import 'package:final_project/view_model/utils/Texts/Texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../view_model/utils/app_colors/app_colors.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextBody14(
          'My Orders',
          fontSize: 18.sp,
          color: AppColors.white,
        ),
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is GetOrdersLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetOrdersErrorState) {
            return Center(child: Text(state.msg));
          } else if (state is GetOrdersSuccessState) {
            final orders = context.read<ProductCubit>().orders.orders ?? [];

            if (orders.isEmpty) {
              return const Center(child: Text('No orders found'));
            }

            return ListView.builder(
              padding: EdgeInsets.all(16.r),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return OrderCard(order: order);
              },
            );
          }
          return const Center(child: Text('No orders found'));
        },
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #${order.id}',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Chip(
                  backgroundColor: _getStatusColor(order.status),
                  label: Text(
                    _getStatusText(order.status),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),

            // Order date
            Text(
              DateFormat('MMM dd, yyyy - hh:mm a').format(order.orderDate!),
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 12.h),

            // Shipping address
            Text(
              'Shipping to:',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              '${order.shippingAddress?.fName} ${order.shippingAddress?.lName}',
              style: TextStyle(fontSize: 14.sp),
            ),
            Text(
              '${order.shippingAddress?.street}, ${order.shippingAddress?.city}',
              style: TextStyle(fontSize: 14.sp),
            ),
            Text(
              order.shippingAddress?.country ?? '',
              style: TextStyle(fontSize: 14.sp),
            ),
            SizedBox(height: 12.h),

            // Order items preview
            Text(
              'Items (${order.items?.length ?? 0}):',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            ...order.items?.take(2).map((item) => Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Image.network(
                              item.pictureUrl ?? '',
                              width: 50.w,
                              height: 50.h,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                width: 50.w,
                                height: 50.h,
                                color: Colors.grey[200],
                                child: const Icon(Icons.image),
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.productName ?? '',
                                  style: TextStyle(fontSize: 14.sp),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '${item.quantity} x \$${item.price?.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )) ??
                [],

            if ((order.items?.length ?? 0) > 2)
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Text(
                  '+ ${(order.items?.length ?? 0) - 2} more items',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            SizedBox(height: 16.h),

            // Order summary
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subtotal:',
                  style: TextStyle(fontSize: 14.sp),
                ),
                Text(
                  '\$${order.subTotal?.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 14.sp),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Shipping (${order.deliveryMethod}):',
                  style: TextStyle(fontSize: 14.sp),
                ),
                Text(
                  '\$${order.deliveryMethodCost?.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 14.sp),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            const Divider(),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total:',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${order.total?.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(int? status) {
    switch (status) {
      case 0: // Pending
        return Colors.orange;
      case 1: // Processing
        return Colors.blue;
      case 2: // Completed
        return Colors.green;
      case 3: // Cancelled
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(int? status) {
    switch (status) {
      case 0:
        return 'Pending';
      case 1:
        return 'Processing';
      case 2:
        return 'Completed';
      case 3:
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }
}
