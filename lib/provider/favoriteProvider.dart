import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:online_ordering_system/Data/favoriteDataModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Favorite with ChangeNotifier {

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
    }
    else{
      var responsebody = jsonDecode(response.body);
      print(responsebody);
    }
    notifyListeners();
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
    }
    else if(response.statusCode == 400){
      var responsebody = jsonDecode(response.body);
      print(responsebody);
    }
    notifyListeners();
  }

  List<FavoriteData> favoriteProduct = [];
  Future<List<FavoriteData>> getMyFavorite(BuildContext context) async {
    try {
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
        print(responsebody);
        favoriteProduct = [FavoriteData.fromJson(responsebody)];
        return favoriteProduct;
      }
      else {
        print(responsebody);
        return favoriteProduct;
      }
    }
    catch (e){
      Navigator.pushNamedAndRemoveUntil(context, '/LoginPage', (route) => false);
      throw e;
    }
  }
}
