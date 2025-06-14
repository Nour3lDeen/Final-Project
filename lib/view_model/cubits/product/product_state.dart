// product_state.dart
part of 'product_cubit.dart';

@immutable
abstract class ProductState {}

final class ProductInitial extends ProductState {}

class ChangeFavoriteState extends ProductState {
  final int productId;
  final bool isFavorite;

  ChangeFavoriteState(this.productId, this.isFavorite);
}

final class ToggleFavoriteLoadingState extends ProductState {}

final class ToggleFavoriteErrorState extends ProductState {
  final String msg;

  ToggleFavoriteErrorState(this.msg);
}

final class GetFavoritesLoadingState extends ProductState {}

final class GetFavoritesSuccessState extends ProductState {}

final class GetFavoritesErrorState extends ProductState {
  final String msg;

  GetFavoritesErrorState(this.msg);
}

final class ProductLoadingState extends ProductState {}

final class ProductSuccessState extends ProductState {}

final class ProductErrorState extends ProductState {
  final String msg;

  ProductErrorState(this.msg);
}

final class CategoryLoadingState extends ProductState {}

final class CategorySuccessState extends ProductState {}

final class CategoryErrorState extends ProductState {
  final String msg;

  CategoryErrorState(this.msg);
}

final class AddToCartLoadingState extends ProductState {}

final class AddToCartSuccessState extends ProductState {}

final class AddToCartErrorState extends ProductState {
  final String msg;

  AddToCartErrorState(this.msg);
}

final class GetCartLoadingState extends ProductState {}

final class GetCartSuccessState extends ProductState {}

final class GetCartErrorState extends ProductState {
  final String msg;

  GetCartErrorState(this.msg);
}

final class ClearCartLoadingState extends ProductState {}

final class ClearCartSuccessState extends ProductState {}

final class ClearCartErrorState extends ProductState {
  final String msg;

  ClearCartErrorState(this.msg);
}

final class RemoveFromCartLoadingState extends ProductState {}

final class RemoveFromCartSuccessState extends ProductState {}

final class RemoveFromCartErrorState extends ProductState {
  final String msg;

  RemoveFromCartErrorState(this.msg);
}

final class CreateOrderLoadingState extends ProductState {}

final class CreateOrderSuccessState extends ProductState {}

final class CreateOrderErrorState extends ProductState {
  final String msg;

  CreateOrderErrorState(this.msg);
}final class GetOrdersLoadingState extends ProductState {}

final class GetOrdersSuccessState extends ProductState {}

final class GetOrdersErrorState extends ProductState {
  final String msg;

  GetOrdersErrorState(this.msg);
}

final class UpdateQuantityLoadingState extends ProductState {}

final class UpdateQuantitySuccessState extends ProductState {}

final class UpdateQuantityErrorState extends ProductState {
  final String msg;

  UpdateQuantityErrorState(this.msg);
}

final class ChangeQuantityState extends ProductState {}
