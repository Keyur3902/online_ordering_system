import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../Data/cartModelData.dart';
import '../state/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartLoadingState()) {
    getMyCart();
  }

  List<CartData> cartProduct = [];
  List<bool> isLoadingList = List.generate(25, (index) => false);
  void getMyCart() async {
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
        if(cartProduct[0].data.isEmpty){
          emit(CartEmptyState());
        }
        else{
          emit(CartLoadedState(cartProduct));
        }
      }
      else if(response.statusCode == 500){
        emit(CartFailedState());
      }
    }
    catch(e){
      emit(CartErrorState(e.toString()));
      throw e;
    }
  }

  addToCart(String productId) async {
    emit(AddToCartLoadingState());
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
    if(response.statusCode == 201){
      emit(AddToCartSuccessState());
      var responsebody = jsonDecode(response.body);
      print(responsebody);
    }
    else if(response.statusCode == 400){
      emit(AddToCartFailedState());
      var responsebody = jsonDecode(response.body);
      print(responsebody);
    }
  }

  removeFromCart(String cartItemId) async {
    emit(RemoveFromCartLoadingState());
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
      emit(RemoveFromCartSuccessState());
      var responsebody = jsonDecode(response.body);
      print('Item Removed from cart');
      print(responsebody);
    }
    else if(response.statusCode == 400){
      emit(RemoveFormCartFailedState());
      var responsebody = jsonDecode(response.body);
      print(responsebody);
    }
  }

  increaseQuantity(cartItemId) async {
    emit(IncreaseCartQuantityLoadingState());
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
      emit(IncreaseCartQuantitySuccessState());
      var responsebody = jsonDecode(response.body);
      print('quantity increased');
      print(responsebody);
    }
    else if(response.statusCode == 400){
      emit(IncreaseCartQuantityFailedState());
      var responsebody = jsonDecode(response.body);
      print(responsebody);
    }
  }

  decreaseQuantity(cartItemId) async {
    emit(DecreaseCartQuantityLoadingState());
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
      emit(DecreaseCartQuantitySuccessState());
      var responsebody = jsonDecode(response.body);
      print(responsebody);
      print('quantity decreased');
    }
    else if(response.statusCode == 400){
      emit(DecreaseCartQuantityFailedState());
      var responsebody = jsonDecode(response.body);
      print(responsebody);
    }
  }

  placeOrder(String cartId, String cartTotal) async {
    emit(OrderPlaceLoadingState());
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
      emit(OrderPlacedSuccessState());
      var responsebody = jsonDecode(response.body);
      print(responsebody);
    }
    else if(response.statusCode == 400){
      emit(OrderPlacedFailedState());
      var responsebody = jsonDecode(response.body);
      print(responsebody);
    }
  }

  onTapEnableButton(int index) {
    isLoadingList[index] = true;
  }

  onTapDisableButton(int index) {
    isLoadingList[index] = false;
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
        backgroundColor: Color(0xFF262a34),
        title: Text(
          "Order Placed🎉",
          style: TextStyle(
            color: Color(0xFF0695b4),
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        content: Text(
          "Your Order Placed Succesfully!!",
          style: TextStyle(
              color: Colors.white70, fontWeight: FontWeight.w600, fontSize: 15),
        ));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}