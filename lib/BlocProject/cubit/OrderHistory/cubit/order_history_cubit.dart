import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Data/orderHistoryDataModel.dart';
import '../state/order_history_state.dart';
import 'package:http/http.dart'as http;

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  OrderHistoryCubit() : super(OrderHistoryLoadingState()) {
    getOrderHistory();
  }

  List<Order> orderItem = [];

  void getOrderHistory() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String jwtToken = preferences.getString('jwtToken').toString();

      final api = 'https://shopping-app-backend-t4ay.onrender.com/order/getOrderHistory';
      final header = {
        'Authorization': 'Bearer $jwtToken',
      };

      var response = await http.get(Uri.parse(api), headers: header);
      var responsebody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        orderItem = [Order.fromJson(responsebody)];
        if(orderItem[0].data.isEmpty){
          emit(OrderHistoryEmptyState());
        }
        else{
          emit(OrderHistoryLoadedState(orderItem));
        }
        print('Hello  ${orderItem[0].data.length}');
      }
      else {
        emit(OrderHistoryFailedState());
        print('Hello ${responsebody}');
      }
    }
    catch (e){
      emit(OrderHistoryErrorState(e.toString()));
      // Navigator.pushNamedAndRemoveUntil(context, '/LoginPage', (route) => false);
      // print(e);
      throw e;
    }
  }
}