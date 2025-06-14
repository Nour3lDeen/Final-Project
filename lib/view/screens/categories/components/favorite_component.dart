import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../../view_model/utils/app_assets/app_assets.dart';
import '../../../../view_model/cubits/product/product_cubit.dart';
import '../../../../view_model/utils/app_colors/app_colors.dart';

class FavoriteComponent extends StatelessWidget {
  const FavoriteComponent({super.key, required this.productId, required this.big});

  final int productId;
  final bool big;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      /*buildWhen: (previous, current) =>
      current is ChangeFavoriteState && current.productId == productId,*/
      builder: (context, state) {
        final cubit = ProductCubit.get(context);
        final isFavorite = cubit.isProductFavorite(productId);

        return GestureDetector(
          onTap: () {
            cubit.toggleFavorite(productId, context);
          },
          child: Container(
            margin: EdgeInsets.only(right: 16.w),
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.6),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.2),
                  blurRadius: 10,
                )
              ],
            ),
            child: Align(
              alignment: AlignmentDirectional.center,
              child: AnimatedScale(
                scale: isFavorite ? 1.2 : 1.0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Padding(
                  padding: EdgeInsets.all(4.sp),
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.white,
                    size: big?28.sp:18.sp,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
