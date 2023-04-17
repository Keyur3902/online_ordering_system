import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Data/orderHistoryDataModel.dart';

class OrderList with ChangeNotifier{
  List<Order> orderItem = [];

  Future<List<Order>> getOrderHistory(BuildContext context) async {
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
        print(responsebody);
        orderItem = [Order.fromJson(responsebody)];
        return orderItem;
      }
      else {
        print(responsebody);
        return orderItem;
      }
    }
    catch (e){
      Navigator.pushNamedAndRemoveUntil(context, '/LoginPage', (route) => false);
      throw e;
    }
  }
}