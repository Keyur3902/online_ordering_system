import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../state/authentication_states.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {

  AuthenticationCubit() : super(AuthenticationInitialState());
  void authentication(
      String userId, String otp) async {
    emit(AuthenticationLoadingState());
    final api =
        'https://shopping-app-backend-t4ay.onrender.com/user/verifyOtpOnRegister';
    final data = {
      "userId": userId,
      "otp": otp,
    };
    var response = await http.post(Uri.parse(api), body: data);
    if (response.statusCode == 200) {
      // Get.snackbar('eshop', 'You have successfully registered!', snackPosition: SnackPosition.BOTTOM, margin: EdgeInsets.only(left: 10, right: 10, bottom: 10));
      emit(AuthenticationSuccessState());
      var responseBody = jsonDecode(response.body);
      print(responseBody);
      // Get.toNamed('/LoginPageGet');
    } else if(response.statusCode == 400){
      emit(AuthenticationFailedState());
      // Get.snackbar('eshop', 'Invalid OTP!', snackPosition: SnackPosition.BOTTOM, margin: EdgeInsets.only(left: 10, right: 10, bottom: 10));
      var responseBody1 = jsonDecode(response.body);
      print(responseBody1);
    }
  }

  void resendOtp(String userId) async {
    final api = 'https://shopping-app-backend-t4ay.onrender.com/user/resendOtp';
    final data = {
      "userId": userId,
    };
    var response = await http.post(Uri.parse(api), body: data);

    if(response.statusCode == 200){
      var responsebody = jsonDecode(response.body);
      print(responsebody);
      emit(ResendOtpState());

    }
  }
}