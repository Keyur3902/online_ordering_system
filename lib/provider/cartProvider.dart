import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:online_ordering_system/Data/cartModelData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Cart with ChangeNotifier {

  void addToCart(String productId) async {
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
      var responsebody = jsonDecode(response.body);
      print(responsebody);
      print('Item Added to cart');
    }
    else if(response.statusCode == 400){
      var responsebody = jsonDecode(response.body);
      print(responsebody);
    }
    notifyListeners();
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
    }
    else if(response.statusCode == 400){
      var responsebody = jsonDecode(response.body);
      print(responsebody);
    }
    notifyListeners();
  }

  List<CartData> cartProduct = [];
  Future<List<CartData>> getMyCart(BuildContext context) async {
    try{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String jwtToken = preferences.getString('jwtToken').toString();
      print(jwtToken);
      final api = 'https://shopping-app-backend-t4ay.onrender.com/cart/getMyCart';
      final header = {"Authorization": 'Bearer $jwtToken'};
      final response = await http.get(Uri.parse(api), headers: header);
      var responsebody = jsonDecode(response.body);
      if(response.statusCode == 200){
        print('itemssdfsdfasdasd1 kjhkhkjh.........$responsebody');
        cartProduct = [CartData.fromJson(responsebody)];
        return cartProduct;
      }
      else{
        return cartProduct;
      }
    }
    catch(e){
      // Navigator.pushNamedAndRemoveUntil(context, '/LoginPage', (route) => false);
      throw e;
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
    }
    else if(response.statusCode == 400){
      var responsebody = jsonDecode(response.body);
      print(responsebody);
    }
    notifyListeners();
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
    }
    else if(response.statusCode == 400){
      var responsebody = jsonDecode(response.body);
      print(responsebody);
    }
    notifyListeners();
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
    }
    else if(response.statusCode == 400){
      var responsebody = jsonDecode(response.body);
      print(responsebody);
    }
    notifyListeners();
  }

  void clearCart() {
    cartProduct.clear();
  }

}

