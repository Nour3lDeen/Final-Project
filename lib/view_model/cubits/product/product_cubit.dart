import 'dart:async';

import 'package:dio/dio.dart';
import 'package:final_project/model/product/cart_item.dart';
import 'package:final_project/model/product/product_model.dart';
import 'package:final_project/view_model/utils/data/local/shared_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../../../model/product/category_model.dart';
import '../../../model/product/orders_model.dart';
import '../../utils/app_colors/app_colors.dart';
import '../../utils/data/local/shared_keys.dart';
import '../../utils/data/network/dio_helper.dart';
import '../../utils/data/network/endpoints.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  static ProductCubit get(context) => BlocProvider.of<ProductCubit>(context);

  bool _isFavorite = false;

  bool get isFavorite => _isFavorite;
  List<ProductModel> favorites = [];

  void toggleFavorite(int productId, BuildContext context) async {
    try {
      emit(ToggleFavoriteLoadingState());

      // Check if the product is already in favorites
      bool isCurrentlyFavorite =
          favorites.any((product) => product.id == productId);

      Response response = await DioHelper.post(
        path: '${EndPoints.toggleFavorite}/$productId',
        withToken: true,
      );
      debugPrint('🔍 API Response: ${response.data}');

      if (response.data != null && response.statusCode == 200) {
        debugPrint('🔍 API Response: ${response.data}');
        if (isCurrentlyFavorite) {
          // Remove product from favorites
          favorites.removeWhere((product) => product.id == productId);
          viewToast(
            'Removed from favorites',
            context,
            Colors.red,
          );
        } else {
          // Add product to favorites
          favorites.add(ProductModel(id: productId));
          viewToast('Added to favorites', context, Colors.green);
        }
        emit(ChangeFavoriteState(productId, isProductFavorite(productId)));
      } else {
        viewToast('Error', context, Colors.red);
        emit(ToggleFavoriteErrorState(response.data['message']));
      }
    } catch (error) {
      viewToast('Error', context, Colors.red);
      emit(ToggleFavoriteErrorState('$error'));
    }
  }

  Future<void> getFavorites() async {
    try {
      emit(GetFavoritesLoadingState());
      debugPrint('Fetching favorites...');

      Response response = await DioHelper.get(
        path: EndPoints.getFavorites,
        withToken: true,
      );

      debugPrint('API Response in getting favorites: ${response.data}');

      if (response.statusCode == 200) {
        // Directly use response.data as it's already a List
        favorites = (response.data as List)
            .map((productJson) => ProductModel.fromJson(productJson))
            .toList();

        debugPrint('Successfully loaded ${favorites.length} favorites');
        emit(GetFavoritesSuccessState());
      } else {
        String errorMessage = response.data['message'] ??
            'Failed with status ${response.statusCode}';
        emit(GetFavoritesErrorState(errorMessage));
        debugPrint('API Error: $errorMessage');
      }
    } on DioException catch (e) {
      String errorMessage =
          e.response?.data['message'] ?? e.message ?? 'Network error occurred';
      debugPrint('Dio Error: $errorMessage');
      emit(GetFavoritesErrorState(errorMessage));
    } catch (e, stackTrace) {
      debugPrint('Unexpected error: $e');
      debugPrint(
          'Stack trace: $stackTrace'); // Add this to see where exactly the error occurs
      emit(GetFavoritesErrorState('An unexpected error occurred'));
    }
  }

  bool isProductFavorite(int productId) {
    return favorites.any((product) => product.id == productId);
  }

  void viewToast(String message, BuildContext context, Color color) {
    showToast(message,
        context: context,
        backgroundColor: color,
        position: StyledToastPosition.bottom,
        animation: StyledToastAnimation.scale,
        reverseAnimation: StyledToastAnimation.fade,
        animDuration: const Duration(seconds: 1),
        duration: const Duration(seconds: 2),
        curve: Curves.elasticOut,
        reverseCurve: Curves.linear,
        borderRadius: BorderRadius.circular(25.r),
        isHideKeyboard: true,
        textStyle: TextStyle(
          color: AppColors.white,
          fontSize: 12.sp,
          fontFamily: 'Poppins',
        ));
  }

  List<ProductModel> products = [];
  List<Category> categories = [];

  Future<void> getCategories() async {
    emit(CategoryLoadingState());
    try {
      final response = await DioHelper.get(
        path: EndPoints.categories,
      );

      if (response.statusCode == 200) {
        final categories = (response.data as List)
            .map((category) => Category.fromJson(category))
            .toList();
        this.categories = categories;
        emit(CategorySuccessState());
      } else {
        emit(CategoryErrorState('Failed to load categories'));
      }
    } catch (e) {
      emit(CategoryErrorState(e.toString()));
    }
  }

  Future<void> getAllProducts() async {
    if (state is ProductLoadingState) return;

    emit(ProductLoadingState());
    try {
      products = await _fetchAllProductsRecursively();
      debugPrint('Successfully loaded ${products.length} total products');
      emit(ProductSuccessState());
    } catch (e) {
      emit(ProductErrorState(e.toString()));
    }
  }

  Future<List<ProductModel>> _fetchAllProductsRecursively({
    int pageIndex = 1,
    int pageSize = 100,
    List<ProductModel> accumulatedProducts = const [],
  }) async {
    final response = await DioHelper.get(
      path: '${EndPoints.products}?pageIndex=$pageIndex&pageSize=$pageSize',
    ).timeout(const Duration(seconds: 30));

    if (response.statusCode != 200 ||
        response.data == null ||
        response.data['data'] == null) {
      throw Exception(_handleErrorResponse(response));
    }

    final currentPageProducts = (response.data['data'] as List)
        .map((product) => ProductModel.fromJson(product))
        .toList();

    final allProducts = [...accumulatedProducts, ...currentPageProducts];

    // Check if we've reached the end (current page has fewer items than pageSize)
    if (currentPageProducts.length < pageSize) {
      return allProducts;
    } else {
      return _fetchAllProductsRecursively(
        pageIndex: pageIndex + 1,
        pageSize: pageSize,
        accumulatedProducts: allProducts,
      );
    }
  }

  /*String _handleDioError(DioException e) {
    if (e.response != null) {
      return 'Server responded with ${e.response!.statusCode}: ${e.response!.statusMessage}';
    } else {
      return 'Network error: ${e.message}';
    }
  }*/

  String _handleErrorResponse(Response response) {
    try {
      // Try to parse error message from response
      return response.data['message'] ??
          'Failed with status ${response.statusCode}';
    } catch (_) {
      return 'Failed with status ${response.statusCode}';
    }
  }

  int quantity = 1;

  void incrementQuantity() {
    quantity++;
    emit(ChangeQuantityState());
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
      emit(ChangeQuantityState());
    }
  }

  void addToCart({required int productId, required int quantity}) async {
    emit(AddToCartLoadingState());

    try {
      final response = await DioHelper.post(
        path: EndPoints.addToCart,
        body: {'productId': productId, 'quantity': quantity},
        withToken: true,
      );

      debugPrint('🔍 API Response: ${response.data}');
      debugPrint('🔍 Status Code: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(AddToCartSuccessState());
      } else if (response.statusCode == 400) {
        emit(AddToCartErrorState('Bad request: Invalid product or quantity'));
      } else if (response.statusCode == 401) {
        emit(AddToCartErrorState('Unauthorized: Please login again'));
      } else if (response.statusCode == 404) {
        emit(AddToCartErrorState('Product not found'));
      } else if (response.statusCode == 500) {
        emit(AddToCartErrorState('Server error: Please try again later'));
      } else {
        emit(AddToCartErrorState('Unexpected error occurred'));
      }
    } catch (e) {
      debugPrint('🔍 Error: $e');
      emit(AddToCartErrorState(e is DioException
          ? e.response?.data['message'] ?? e.message ?? 'Network error occurred'
          : 'An unexpected error occurred'));
    }
  }

  CartItem cartItem = CartItem();

  void getCart() async {
    emit(GetCartLoadingState());
    try {
      final response = await DioHelper.get(
        path: EndPoints.getCart,
        withToken: true,
      );

      debugPrint('🔍 API Response: ${response.data}');
      debugPrint('🔍 Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        cartItem = CartItem.fromJson(response.data);
        debugPrint('🔍 Cart Item: ${cartItem.toString()}');
        emit(GetCartSuccessState());
      } else if (response.statusCode == 401) {
        emit(GetCartErrorState('Unauthorized: Please login again'));
      } else {
        emit(GetCartErrorState('Unexpected error occurred'));
      }
    } catch (e) {
      debugPrint('🔍 Error: $e');
      emit(GetCartErrorState(e is DioException && e.response?.statusCode == 404
          ? 'The Cart is empty' ??
              e.response?.data['message'] ??
              e.message ??
              'Network error occurred'
          : 'An unexpected error occurred'));
    }
  }

  void clearCart() async {
    emit(ClearCartLoadingState());
    try {
      final response = await DioHelper.delete(
        path: EndPoints.clearCart,
        withToken: true,
      );

      debugPrint('🔍 API Response: ${response.data}');
      debugPrint('🔍 Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        cartItem.items?.clear();
        emit(ClearCartSuccessState());
      } else if (response.statusCode == 401) {
        emit(ClearCartErrorState('Unauthorized: Please login again'));
      } else {
        emit(ClearCartErrorState('Unexpected error occurred'));
      }
    } catch (e) {
      debugPrint('🔍 Error: $e');
      emit(ClearCartErrorState(e is DioException
          ? e.response?.data['message'] ?? e.message ?? 'Network error occurred'
          : 'An unexpected error occurred'));
    }
  }

  void removeFromCart({required int productId}) async {
    emit(RemoveFromCartLoadingState());
    try {
      final response = await DioHelper.delete(
        path: '${EndPoints.removeFromCart}/$productId',
        withToken: true,
      );

      debugPrint('🔍 API Response: ${response.data}');
      debugPrint('🔍 Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        cartItem.items?.removeWhere((item) => item.productId == productId);
        emit(RemoveFromCartSuccessState());
      } else if (response.statusCode == 401) {
        emit(RemoveFromCartErrorState('Unauthorized: Please login again'));
      } else if (response.statusCode == 404) {
        emit(RemoveFromCartErrorState('Product not found'));
      } else {
        emit(RemoveFromCartErrorState('Unexpected error occurred'));
      }
    } catch (e) {
      debugPrint('🔍 Error: $e');
      emit(RemoveFromCartErrorState(e is DioException
          ? e.response?.data['message'] ?? e.message ?? 'Network error occurred'
          : 'An unexpected error occurred'));
    }
  }

  void updateQuantity(
      {required int productId, required String operation}) async {
    emit(UpdateQuantityLoadingState());
    try {
      final response = await DioHelper.post(
        path:
            '${operation == 'increment' ? EndPoints.increaseQuantity : EndPoints.decreaseQuantity}/$productId',
        withToken: true,
      );
      debugPrint('🔍 Operation: $operation');
      debugPrint('🔍 ProductId: $productId');
      debugPrint('🔍 API Response: ${response.data}');
      debugPrint('🔍 Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        getCart();
        emit(UpdateQuantitySuccessState());
      } else if (response.statusCode == 401) {
        emit(UpdateQuantityErrorState('Unauthorized: Please login again'));
      } else if (response.statusCode == 404) {
        emit(UpdateQuantityErrorState('Product not found'));
      } else {
        emit(UpdateQuantityErrorState('Unexpected error occurred'));
      }
    } catch (e) {
      debugPrint('🔍 Error: $e');
      emit(UpdateQuantityErrorState(e is DioException
          ? e.response?.data['message'] ?? e.message ?? 'Network error occurred'
          : 'An unexpected error occurred'));
    }
  }

  void createOrder() async {
    emit(CreateOrderLoadingState());
    try {
      final response = await DioHelper.post(
        path: EndPoints.createOrder,
        body: {
          'phoneNumber': SharedHelper.getData(SharedKeys.phone),
        },
        withToken: true,
      );

      debugPrint('🔍 API Response: ${response.data}');
      debugPrint('🔍 Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        emit(CreateOrderSuccessState());
      } else if (response.statusCode == 401) {
        emit(CreateOrderErrorState('Unauthorized: Please login again'));
      } else {
        emit(CreateOrderErrorState('Unexpected error occurred'));
      }
    } catch (e) {
      debugPrint('🔍 Error: $e');
    }
  }

  Orders orders = Orders();

  void getOrders() async {
    emit(GetOrdersLoadingState());
    try {
      final response = await DioHelper.get(
        path: EndPoints.getOrders,
        withToken: true,
      );

      debugPrint('🔍 API Response: ${response.data}');
      debugPrint('🔍 Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        // Handle the list response
        orders = Orders.fromJson(response.data);
        debugPrint('🔍 Orders: ${orders.orders?.length} orders loaded');
        emit(GetOrdersSuccessState());
      } else if (response.statusCode == 401) {
        emit(GetOrdersErrorState('Unauthorized: Please login again'));
      } else {
        emit(GetOrdersErrorState('Unexpected error occurred'));
      }
    } catch (e) {
      debugPrint('🔍 Error: $e');
      emit(GetOrdersErrorState(e is DioException
          ? e.response?.data['message'] ?? e.message ?? 'Network error occurred'
          : 'An unexpected error occurred'));
    }
  }
}
