import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_ordering_system/BlocProject/cubit/Authentication/state/authenticationOnForgotPass_states.dart';

class AuthenticationOnForgotPassCubit extends Cubit<AuthenticationOnForgotPassState> {

  AuthenticationOnForgotPassCubit() : super(AuthenticationOnForgotPassInitialState());

  void resendOtp(String userId) async {
    final api = 'https://shopping-app-backend-t4ay.onrender.com/user/resendOtp';
    final data = {
      "userId": userId,
    };
    var response = await http.post(Uri.parse(api), body: data);

    if(response.statusCode == 200){
      emit(AuthenticationResendOtpState());
      var responsebody = jsonDecode(response.body);
      print(responsebody);

      // setState(() {
      //   _isResendAgain = true;
      // });

      // const oneSec = Duration(seconds: 1);
      // _timer = Timer.periodic(oneSec, (timer) {
      //   setState(() {
      //     if (_start == 0) {
      //       _start = 60;
      //       _isResendAgain = false;
      //       timer.cancel();
      //     } else {
      //       _start--;
      //     }
      //   });
      // });
    }
  }

  void authentication(
      String userId, String otp) async {
    emit(AuthenticationOnForgotPassLoadingState());
    final api =
        'https://shopping-app-backend-t4ay.onrender.com/user/verifyOtpOnForgotPassword';
    final data = {
      "userId": userId,
      "otp": otp,
    };
    var response = await http.post(Uri.parse(api), body: data);

    if (response.statusCode == 200) {
      emit(AuthenticationOnForgotPassSuccessState());
      var responseBody = jsonDecode(response.body);
      print(responseBody);
      // Get.snackbar('eshop'.tr, 'OTP Verified Successfully And password sent to your Mail!'.tr, snackPosition: SnackPosition.BOTTOM, margin: EdgeInsets.only(left: 10, right: 10, bottom: 10));
      // Get.toNamed('/LoginPageGet');

    } else if(response.statusCode == 400){
      emit(AuthenticationOnForgotPassFailedState());
      // Get.snackbar('eshop'.tr, 'Invalid OTP!'.tr, snackPosition: SnackPosition.BOTTOM, margin: EdgeInsets.only(left: 10, right: 10, bottom: 10));
      var responseBody1 = jsonDecode(response.body);
      print(responseBody1);
    }
  }
}