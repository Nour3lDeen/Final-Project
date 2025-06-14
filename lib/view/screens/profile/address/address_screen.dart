import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../view_model/cubits/auth/auth_cubit.dart';
import '../../../../view_model/utils/app_colors/app_colors.dart';
import '../../../../view_model/utils/data/local/shared_helper.dart';
import '../../../../view_model/utils/data/local/shared_keys.dart';


class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shipping Address',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      floatingActionButton: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final hasAddress = SharedHelper.getData(SharedKeys.street) != null &&
              SharedHelper.getData(SharedKeys.country) != null &&
              SharedHelper.getData(SharedKeys.city) != null;

          return hasAddress ? const SizedBox() : FloatingActionButton(
            backgroundColor: AppColors.primaryColor,
            onPressed: () => _showAddAddressDialog(context),
            child: const Icon(Icons.add, color: Colors.white),
          );
        },
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is GetUserAddressLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          }

          final hasAddress = SharedHelper.getData(SharedKeys.street) != null &&
              SharedHelper.getData(SharedKeys.country) != null &&
              SharedHelper.getData(SharedKeys.city) != null;

          return Padding(
            padding: EdgeInsets.all(16.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!hasAddress)
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_off,
                            size: 48.sp,
                            color: AppColors.primaryColor.withValues(alpha: 0.5),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'No Address Saved',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Tap the + button to add your address',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: AppColors.primaryColor,
                                size: 24.sp,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Your Shipping Address',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColor,
                                ),
                              ),

                            ],
                          ),
                          SizedBox(height: 16.h),
                          _buildAddressItem(
                            icon: Icons.flag,
                            title: 'Country',
                            value: SharedHelper.getData(SharedKeys.country),
                          ),
                          SizedBox(height: 12.h),
                          _buildAddressItem(
                            icon: Icons.location_city,
                            title: 'City',
                            value: SharedHelper.getData(SharedKeys.city),
                          ),
                          SizedBox(height: 12.h),
                          _buildAddressItem(
                            icon: Icons.streetview,
                            title: 'Street',
                            value: SharedHelper.getData(SharedKeys.street),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAddressItem({
    required IconData icon,
    required String title,
    required String? value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20.sp,
          color: Colors.grey[600],
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                value ?? 'Not specified',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showAddAddressDialog(BuildContext context) {

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Add Shipping Address',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildAddressTextField(
                controller: AuthCubit.get(context).countryController,
                label: 'Country',
                icon: Icons.flag,
              ),
              SizedBox(height: 12.h),
              _buildAddressTextField(
                controller: AuthCubit.get(context).cityController,
                label: 'City',
                icon: Icons.location_city,
              ),
              SizedBox(height: 12.h),
              _buildAddressTextField(
                controller: AuthCubit.get(context).streetController,
                label: 'Street Address',
                icon: Icons.streetview,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14.sp,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            onPressed: () {
              if (AuthCubit.get(context).countryController.text.isNotEmpty &&
                  AuthCubit.get(context).cityController.text.isNotEmpty &&
                  AuthCubit.get(context).streetController.text.isNotEmpty) {
                context.read<AuthCubit>().addAddress(

                );
                Navigator.pop(context);
              }
            },
            child: Text(
              'Save Address',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 20.sp),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 12.w,
        ),
      ),
    );
  }
}