import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_ordering_system/BlocProject/cubit/Login/state/forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {

  ForgotPasswordCubit() : super(ForgotPasswordInitialState());

  String? userId;

  void forgotPassword(String emailId) async {
    emit(ForgotPasswordLoadingState());
    final api = 'https://shopping-app-backend-t4ay.onrender.com/user/forgotPassword';

    final data = {
      "emailId" : emailId,
    };
    var response = await http.post(Uri.parse(api), body: data);

    if(response.statusCode == 200){
      emit(ForgotPasswordSuccessState());
      var responsebody = jsonDecode(response.body);
      print(responsebody);
      userId = responsebody['data']['_id'];
      // Get.snackbar('eshop', 'Please verify otp sent to your email!', snackPosition: SnackPosition.BOTTOM, margin: EdgeInsets.only(left: 10, right: 10, bottom: 10));
      // Get.toNamed('/OtpOnForgotPasswordPageGet', arguments: userId);
    }
    else if(response.statusCode == 400){
      emit(ForgotPasswordFailedState());
      // Get.snackbar('eshop', 'This Email Id is not Registered With us kindly register first!', snackPosition: SnackPosition.BOTTOM, margin: EdgeInsets.only(left: 10, right: 10, bottom: 10));
      var responsebody = jsonDecode(response.body);
      print(responsebody);
    }
  }
}