import 'dart:convert';
import 'package:get/get.dart';
import 'package:online_ordering_system/GetxProject/ModelClassGetx/cartModelClassGet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CartControllerGetx extends GetxController {

  RxBool isLoadingAddToCart = true.obs;

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
      update();
    }
    else if(response.statusCode == 400){
      var responsebody = jsonDecode(response.body);
      print(responsebody);
      update();
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

  RxList<CartDataGet> cartProduct = <CartDataGet>[].obs;
  RxBool isLoadingGetCart = true.obs;
  CartDataGet cartDataGet = CartDataGet(status: 0, msg: '', cartTotal: 0, data: []);

  @override
  void onInit(){
    super.onInit();
    getMyCartGet();
  }


  Future<void> getMyCartGet() async {
    try{
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
        isLoadingGetCart.value = true;
        // update();
      }
      else{
        cartDataGet = CartDataGet.fromJson(responsebody);
        isLoadingGetCart.value = false;
        // update();
      }
    }
    catch(e){
      print('itemssdfsdfasdasd1 kjhkhkjh.........$e');
      // Get.offAllNamed('/LoginPage');
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
  }

}

