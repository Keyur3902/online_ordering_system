import '../../../../Data/orderHistoryDataModel.dart';

abstract class OrderHistoryState {}

class OrderHistoryLoadingState extends OrderHistoryState {}

class OrderHistoryLoadedState extends OrderHistoryState {
  final List<Order> orderItem;
  OrderHistoryLoadedState(this.orderItem);
}

class OrderHistoryFailedState extends OrderHistoryState {}

class OrderHistoryErrorState extends OrderHistoryState {
  final String errorMessage;
  OrderHistoryErrorState(this.errorMessage);
}

class OrderHistoryEmptyState extends OrderHistoryState {}