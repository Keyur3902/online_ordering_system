import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:online_ordering_system/GetxProject/ModelClassGetx/favoriteModelClassGet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteControllerGetx extends GetxController{

  void addToFavorite(String productId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var jwtToken = preferences.getString('jwtToken');
    print(jwtToken);

    final api = 'https://shopping-app-backend-t4ay.onrender.com/watchList/addToWatchList';
    final data = {
      'productId' : productId,
    };
    final header = {
      'Authorization' : 'Bearer $jwtToken',
    };

    var response = await http.post(Uri.parse(api), body: data, headers: header);

    if(response.statusCode == 200){
      var responsebody = jsonDecode(response.body);
      print(responsebody);
      print('Item Added to favorite');
      update();
    }
    else{
      var responsebody = jsonDecode(response.body);
      print(responsebody);
      update();
    }
  }

  void removeFromFavorite(String favoriteItemId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jwtToken = preferences.getString('jwtToken').toString();
    print(jwtToken);
    final api = 'https://shopping-app-backend-t4ay.onrender.com/watchList/removeFromWatchList';
    final data = {
      'wathListItemId' : favoriteItemId,
    };
    final header = {
      'Authorization' : 'Bearer $jwtToken',
    };

    var response = await http.post(Uri.parse(api), body: data, headers: header);

    if(response.statusCode == 200){
      var responsebody = jsonDecode(response.body);
      print('Item removed from favorite');
      print(responsebody);
      // update();
    }
    else if(response.statusCode == 400){
      var responsebody = jsonDecode(response.body);
      print(responsebody);
      // update();
    }
  }

  @override
  void onInit(){
    super.onInit();
    getMyFavorite();
  }

  FavoriteDataGet favoriteDataGet = FavoriteDataGet(status: 0, msg: '', data: []);
  RxBool isLoadingGetFav = false.obs;
  // RxList<FavoriteDataGet> favoriteProduct = <FavoriteDataGet>[].obs;
  Future<void> getMyFavorite() async {
    try {
      isLoadingGetFav.value = true;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String jwtToken = preferences.getString('jwtToken').toString();
      print(jwtToken);

      final api = 'https://shopping-app-backend-t4ay.onrender.com/watchList/getWatchList';
      final header = {
        'Authorization': 'Bearer $jwtToken',
      };
      final response = await http.get(Uri.parse(api), headers: header);
      var responsebody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // favoriteDataGet = FavoriteDataGet.fromJson(responsebody);
        favoriteDataGet = FavoriteDataGet.fromJson(responsebody);
        print('asdljfasdlfhalsjd ======${responsebody}');
        // return favoriteDataGet;
        update();
      }
      else {
        print(responsebody);
        // favoriteDataGet = FavoriteDataGet.fromJson(responsebody);
        favoriteDataGet = FavoriteDataGet.fromJson(responsebody);
        // return favoriteProduct;
        update();
      }
    }
    catch (e){
      // Get.offAllNamed('/LoginPage');
      throw e;
    }
    finally{
      isLoadingGetFav.value = false;
    }
  }

}