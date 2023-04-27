import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../ModelClassGetx/orderHistoryDataModelGet.dart';

class OrderListControllerGetx extends GetxController{
  // RxList<OrderGet> orderItem = <OrderGet>[].obs;
  RxBool isLoadingData = false.obs;
  OrderGet orderGet = OrderGet(status: 0, msg: '', data: []);

  @override
  void onInit(){
    super.onInit();
    getOrderHistory();
  }

  Future<void> getOrderHistory() async {
    try {
      isLoadingData.value = true;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String jwtToken = preferences.getString('jwtToken').toString();

      final api = 'https://shopping-app-backend-t4ay.onrender.com/order/getOrderHistory';
      final header = {
        'Authorization': 'Bearer $jwtToken',
      };

      var response = await http.get(Uri.parse(api), headers: header);
      var responsebody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        orderGet = OrderGet.fromJson(responsebody);
        print(response.statusCode);
        // print('Hello  ${orderItem[0].data.length}');
        update();
      }
      else {
        print('Hello ${responsebody}');
        orderGet = OrderGet.fromJson(responsebody);
        update();
      }
    }
    catch (e){
      Get.offAllNamed('/LoginPageGet');
      print(e);
      throw e;
    }
    finally{
      isLoadingData.value = false;
    }
  }
}