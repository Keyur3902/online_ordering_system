import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_ordering_system/BlocProject/cubit/Register/state/register_states.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  String? userId;
  void register(
      String name, String mobileNo, String emailId, String password) async {
    emit(RegisterLoadingState());
    const api =
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
      emit(RegistrationVerificationState());
      // Get.snackbar('eshop', 'Please verify OTP sent to your mail!', snackPosition: SnackPosition.BOTTOM, margin: EdgeInsets.only(left: 10, right: 10, bottom: 10));
      // Get.toNamed('/OtpOnRegisterPageGet', arguments: userId);
    } else if (response.statusCode == 400) {
      var responseBody1 = jsonDecode(response.body);
      emit(RegistrationFailedState());
      // Get.snackbar('eshop', 'Email already registered!! try using another EmailId', snackPosition: SnackPosition.BOTTOM, margin: EdgeInsets.only(left: 10, right: 10, bottom: 10));
      print(responseBody1);
    }
  }
}