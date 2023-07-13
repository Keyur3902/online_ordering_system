import '../../../../Data/data.dart';

abstract class ProductListState {}

class ProductListInitialState extends ProductListState {}

class ProductListLoadingState extends ProductListState {}

class ProductListLoadedState extends ProductListState {
  final List<Welcome> data;
  ProductListLoadedState(this.data);
}

class ProductListErrorState extends ProductListState {}

class ProductListFailedState extends ProductListState {
  final String errorMessage;
  ProductListFailedState(this.errorMessage);
}

