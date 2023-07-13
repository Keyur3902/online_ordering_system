import '../../../../Data/cartModelData.dart';

abstract class CartState {}

class CartLoadingState extends CartState {}

class CartLoadedState extends CartState {
  final List<CartData> cartProduct;
  CartLoadedState(this.cartProduct);
}

class CartFailedState extends CartState {}

class CartErrorState extends CartState {
  final String errorMessage;
  CartErrorState(this.errorMessage);
}

class CartEmptyState extends CartState {}

class AddToCartLoadingState extends CartState {}

class AddToCartSuccessState extends CartState {}

class AddToCartFailedState extends CartState {}

class RemoveFromCartLoadingState extends CartState {}

class RemoveFromCartSuccessState extends CartState {}

class RemoveFormCartFailedState extends CartState {}

class IncreaseCartQuantityLoadingState extends CartState {}

class IncreaseCartQuantitySuccessState extends CartState {}

class IncreaseCartQuantityFailedState extends CartState {}

class DecreaseCartQuantityLoadingState extends CartState {}

class DecreaseCartQuantitySuccessState extends CartState {}

class DecreaseCartQuantityFailedState extends CartState {}

class OrderPlaceLoadingState extends CartState {}

class OrderPlacedSuccessState extends CartState {}

class OrderPlacedFailedState extends CartState {}


