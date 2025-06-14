import 'package:final_project/view/screens/categories/cart/cart_screen.dart';
import 'package:final_project/view/screens/favorites/favorites_screen.dart';
import 'package:final_project/view/screens/profile/address/address_screen.dart';
import 'package:final_project/view_model/cubits/product/product_cubit.dart';
import 'package:final_project/view_model/utils/Texts/Texts.dart';
import 'package:final_project/view_model/utils/app_colors/app_colors.dart';
import 'package:final_project/view_model/utils/data/local/shared_helper.dart';
import 'package:final_project/view_model/utils/data/local/shared_keys.dart';
import 'package:final_project/view_model/utils/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../view_model/cubits/auth/auth_cubit.dart';
import '../auth/welcome_screen/welcome_screen.dart';
import '../categories/cart/orders_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(12.sp),
      children: [
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            final cubit = AuthCubit.get(context);
            final profileImage = cubit.profileImage;
            return GestureDetector(
              onTap: () => cubit.changeProfilePicture(),
              child: Center(
                child: SizedBox(
                  width: 100.r,
                  height: 100.r,
                  child: Stack(
                    children: [
                      ClipOval(
                        child: SharedHelper.getData(SharedKeys.avatar) != null
                            ? Image.network(
                                SharedHelper.getData(SharedKeys.avatar),
                                width: 100.r,
                                height: 100.r,
                                fit: BoxFit.cover,
                              )
                            : profileImage != null
                                ? Image.file(
                                    profileImage,
                                    width: 100.r,
                                    height: 100.r,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    color: Colors.green[200],
                                    width: 100.r,
                                    height: 100.r,
                                    child: Icon(Icons.person,
                                        size: 50, color: Colors.green[900]),
                                  ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        SizedBox(height: 8.h),
        TextBody14(
          '${AuthCubit.get(context).user?.firstName} ${AuthCubit.get(context).user?.lastName}',
          textAlign: TextAlign.center,
          fontWeight: FontWeight.bold,
          fontSize: 18.sp,
          color: AppColors.secondaryColor,
        ),
        SizedBox(height: 6.h),
        TextBody14(
          '${SharedHelper.getData(SharedKeys.email)}',
          textAlign: TextAlign.center,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.secondaryColor,
        ),
        SizedBox(height: 6.h),
        TextBody14(
          '${SharedHelper.getData(SharedKeys.phone)}',
          textAlign: TextAlign.center,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.secondaryColor,
        ),
        const Divider(height: 40, thickness: 1),
        GestureDetector(
          onTap: () {
            ProductCubit.get(context).getCart();
            Navigation.push(context, const CartScreen());
          },
          child: ListTile(
            leading: Icon(Icons.shopping_cart, color: Colors.green[700]),
            title: const TextBody14('My Cart'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          ),
        ),
        GestureDetector(
          onTap: () {
            ProductCubit.get(context).getOrders();
            Navigation.push(context, const OrdersScreen());
          },
          child: ListTile(
            leading: Icon(Icons.shopping_bag, color: Colors.green[700]),
            title: const TextBody14('My Orders'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          ),
        ),
        GestureDetector(
          onTap: () {
            AuthCubit.get(context).getUserAddress();
            Navigation.push(context, const AddressScreen());
          },
          child: ListTile(
            leading: Icon(Icons.location_on_outlined, color: Colors.green[700]),
            title: const TextBody14('My Address'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          ),
        ),
        GestureDetector(
          onTap: () {
            ProductCubit.get(context).getFavorites();
            debugPrint(
                'Favorites: ${ProductCubit.get(context).favorites.length}');
            Navigation.push(context, FavoritesScreen());
          },
          child: ListTile(
            leading: Icon(Icons.favorite, color: Colors.green[700]),
            title: const TextBody14('Favorites'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          ),
        ),
/*
        ListTile(
          leading: Icon(Icons.settings, color: Colors.green[700]),
          title: const TextBody14('Settings'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
*/
        InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: const TextTitle('Logout'),
                      content:
                          const TextBody12('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: TextBody14(
                              'Cancel',
                              color: AppColors.primaryColor,
                            )),
                        TextButton(
                            onPressed: () {
                              AuthCubit.get(context).logout();
                              AuthCubit.get(context).viewToast(
                                  'Logged out successfully',
                                  context,
                                  Colors.green,
                                  2);
                              Navigation.pushAndRemove(
                                  context, const WelcomeScreen());
                            },
                            child:
                                const TextBody14('Logout', color: Colors.red)),
                      ],
                    ));
          },
          child: const ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: TextBody14('Logout'),
          ),
        ),
      ],
    );
  }
}
