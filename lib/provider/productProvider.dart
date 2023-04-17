import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:online_ordering_system/Data/data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GetProductProvider with ChangeNotifier{
  List<Welcome> data = [];
  List<Welcome> search = [];
  String searchText = '';

  Future<List<Welcome>> getData(BuildContext context) async {
    try{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jwtToken = preferences.getString('jwtToken') ?? '';
    final api =
        'https://shopping-app-backend-t4ay.onrender.com/product/getAllProduct';
    final header = {"Authorization": 'Bearer $jwtToken'};
    final response = await http.get(Uri.parse(api), headers: header);
    var item = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(item);
      data = [Welcome.fromJson(item)];
      return data;
    }
    else{
      print('sadsdasdasdasd${item}');
      return data;
    }
    }
    catch(e){
      Navigator.pushNamedAndRemoveUntil(context, '/LoginPage', (route) => false);
      throw e;
    }
  }
    bool isLoaded = false;

}