import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:online_ordering_system/GetxProject/ModelClassGetx/cartModelClassGet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CartControllerGetx extends GetxController {

  RxBool isLoadingAddToCart = true.obs;

  Future<void> addToCart(String productId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jwtToken = preferences.getString('jwtToken').toString();
    print(jwtToken);
    final api = 'https://shopping-app-backend-t4ay.onrender.com/cart/addToCart';
    final data = {
      'productId' : productId,
    };
    final header = {
      'Authorization' : 'Bearer $jwtToken',
    };

    var response = await http.post(Uri.parse(api), body: data, headers: header);
    var responsebody = jsonDecode(response.body);
    print(responsebody);
    if(response.statusCode == 200){
      update();
      var responsebody = jsonDecode(response.body);
      print(responsebody);
    }
    else if(response.statusCode == 400){
      update();
      var responsebody = jsonDecode(response.body);
      print(responsebody);
    }
  }

  void removeFromCart(String cartItemId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jwtToken = preferences.getString('jwtToken').toString();
    print(jwtToken);
    final api = 'https://shopping-app-backend-t4ay.onrender.com/cart/removeProductFromCart';
    final data = {
      'cartItemId' : cartItemId,
    };
    final header = {
      'Authorization': 'Bearer $jwtToken',
    };

    var response = await http.post(Uri.parse(api), body: data, headers: header);

    if(response.statusCode == 200){
      var responsebody = jsonDecode(response.body);
      print('Item Removed from cart');
      print(responsebody);
      update();
    }
    else if(response.statusCode == 400){
      var responsebody = jsonDecode(response.body);
      print(responsebody);
      update();
    }
  }

  // RxList<CartDataGet> cartProduct = <CartDataGet>[].obs;
  RxBool isLoadingGetCart = false.obs;
  CartDataGet cartDataGet = CartDataGet(status: 0, msg: '', cartTotal: 0, data: <CartProductGet>[]);

  @override
  void onInit(){
    super.onInit();
    getMyCartGet();
  }


  Future<void> getMyCartGet() async {
    try{
      isLoadingGetCart.value = true;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String jwtToken = preferences.getString('jwtToken').toString();
      print(jwtToken);
      final api = 'https://shopping-app-backend-t4ay.onrender.com/cart/getMyCart';
      final header = {"Authorization": 'Bearer $jwtToken'};
      final response = await http.get(Uri.parse(api), headers: header);
      var responsebody = jsonDecode(response.body);
      if(response.statusCode == 200){
        cartDataGet = CartDataGet.fromJson(responsebody);
        print('itemssdfsdfasdasd1 kjhkhkjh.........$responsebody');
        // return cartProduct;
        update();
      }
      else{
        cartDataGet = CartDataGet.fromJson(responsebody);
        // return cartProduct;
        update();
      }
    }
    catch(e){
      print('itemssdfsdfasdasd1 kjhkhkjh.........$e');
      Get.offAllNamed('/LoginPageGet');
      throw e;
    }
    finally{
      isLoadingGetCart.value = false;
    }
  }

  void increaseQuantity(cartItemId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jwtToken = preferences.getString('jwtToken').toString();
    print(jwtToken);
    final api = 'https://shopping-app-backend-t4ay.onrender.com/cart/increaseProductQuantity';
    final data = {
      'cartItemId' : cartItemId,
    };
    final header = {
      'Authorization' : 'Bearer $jwtToken',
    };

    final response = await http.post(Uri.parse(api), body: data, headers: header);

    if(response.statusCode == 200){
      var responsebody = jsonDecode(response.body);
      print('quantity increased');
      print(responsebody);
      update();
    }
    else if(response.statusCode == 400){
      var responsebody = jsonDecode(response.body);
      print(responsebody);
      update();
    }
  }

  void decreaseQuamtity(cartItemId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jwtToken = preferences.getString('jwtToken').toString();
    print(jwtToken);

    final api = 'https://shopping-app-backend-t4ay.onrender.com/cart/decreaseProductQuantity';
    final data = {
      'cartItemId' : cartItemId,
    };
    final header = {
      'Authorization' : 'Bearer $jwtToken',
    };

    var response = await http.post(Uri.parse(api), body: data, headers: header);

    if(response.statusCode == 200){
      var responsebody = jsonDecode(response.body);
      print(responsebody);
      print('quantity decreased');
      update();
    }
    else if(response.statusCode == 400){
      var responsebody = jsonDecode(response.body);
      print(responsebody);
      update();
    }
  }

  placeOrder(String cartId, String cartTotal) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jwtToken = preferences.getString('jwtToken').toString();

    final api = 'https://shopping-app-backend-t4ay.onrender.com/order/placeOrder';
    final data = {
      'cartId' : cartId,
      'cartTotal' : cartTotal,
    };
    final header = {
      'Authorization' : 'Bearer $jwtToken',
    };

    var response = await http.post(Uri.parse(api), body: data, headers: header);

    if(response.statusCode == 200){
      var responsebody = jsonDecode(response.body);
      print(responsebody);
      update();
    }
    else if(response.statusCode == 400){
      var responsebody = jsonDecode(response.body);
      print(responsebody);
      update();
    }
  }

}

