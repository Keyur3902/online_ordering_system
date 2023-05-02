import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthControllerGet extends GetxController{

  addStringToSF(String value, String value1, String value2, bool value3, String name, String mobileNo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('jwtToken', value);
    preferences.setString('emailId', value1);
    preferences.setString('password', value2);
    preferences.setString('name', name);
    preferences.setString('mobileNo', mobileNo);
    preferences.setBool('isLogin', value3);
  }

  void login(
      String emailId, String password) async {
    final api =
        'https://shopping-app-backend-t4ay.onrender.com/user/login';
    final data = {
      "emailId": emailId,
      "password": password,
    };
    var response = await http.post(Uri.parse(api), body: data);

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      print(responseBody);
      var jwtToken = responseBody['data']['jwtToken'];
      print(jwtToken);
      bool isLogin1 = responseBody['status'] == 1;
      var name = responseBody['data']['name'];
      var mobileNo = responseBody['data']['mobileNo'];
      addStringToSF(jwtToken, emailId, password, isLogin1, name, mobileNo);
      Get.offNamed('/BottomNavigationGet');
    } else if(response.statusCode == 400){
      var responseBody1 = jsonDecode(response.body);
      Get.snackbar(
          'Error!!!'.tr, 'Invalid username or password!'.tr, margin: EdgeInsets.only(
          bottom: 10,
          left: 10,
          right: 15)
      );
      print(responseBody1);
    }
    else{
      Get.snackbar(
          'Error!!!'.tr, 'Invalid username or password!'.tr, margin: EdgeInsets.only(
          bottom: 10,
          left: 10,
          right: 15)
      );
      Get.offNamedUntil('/LoginPageGet', (route) => false);
    }
  }


  String? userId;
  void register(
      String name, String mobileNo, String emailId, String password) async {
    final api =
        'https://shopping-app-backend-t4ay.onrender.com/user/registerUser';
    final data = {
      "name": name,
      "mobileNo": mobileNo,
      "emailId": emailId,
      "password": password,
    };
    var response = await http.post(Uri.parse(api), body: data);

    if (response.statusCode == 201) {
      var responseBody = jsonDecode(response.body);
      print(responseBody);
      userId = responseBody['data']['_id'];
      Get.snackbar('eshop'.tr, 'Please verify OTP sent to your mail!'.tr, snackPosition: SnackPosition.BOTTOM, margin: EdgeInsets.only(left: 10, right: 10, bottom: 10));
      Get.toNamed('/OtpOnRegisterPageGet', arguments: userId);
    } else if (response.statusCode == 400) {
      var responseBody1 = jsonDecode(response.body);
      // ScaffoldMessenger.of(context).hideCurrentSnackBar();
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Get.snackbar('eshop'.tr, 'Email already registered!! try using another EmailId'.tr, snackPosition: SnackPosition.BOTTOM, margin: EdgeInsets.only(left: 10, right: 10, bottom: 10));
      print(responseBody1);
    }
  }
}