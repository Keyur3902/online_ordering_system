import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_ordering_system/BlocProject/cubit/Login/state/login_states.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCubit extends Cubit<LoginState>{

  LoginCubit() : super(LoginInitialState());

  addStringToSF(String value, String value1, String value2, bool value3, String name, String mobileNo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('jwtToken', value);
    preferences.setString('emailId', value1);
    preferences.setString('password', value2);
    preferences.setString('name', name);
    preferences.setString('mobileNo', mobileNo);
    preferences.setBool('isLogin', value3);
  }

  void login(String emailId, String password) async {
    emit(LoginLoadingState());
    const api =
        'https://shopping-app-backend-t4ay.onrender.com/user/login';
    final data = {
      "emailId": emailId,
      "password": password,
    };
    var response = await http.post(Uri.parse(api), body: data);
    try{
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        var jwtToken = responseBody['data']['jwtToken'];
        bool isLogin1 = responseBody['status'] == 1;
        var name = responseBody['data']['name'];
        var mobileNo = responseBody['data']['mobileNo'];
        addStringToSF(jwtToken, emailId, password, isLogin1, name, mobileNo);
        emit(LoginSuccessState());
      } else if(response.statusCode == 400){
        var responseBody1 = jsonDecode(response.body);
        emit(LoginErrorState());
        print(responseBody1);
      }
    }
    catch(e){
      emit(LoginFailedState());
    // Get.offNamedUntil('/LoginPageGet', (route) => false);
    }
  }

}