import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_ordering_system/BlocProject/cubit/Accounts/state/change_password_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitialState());

  void changePassword(String newPass, String confirmPass) async {
    emit(ChangePasswordLoadingState());
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jwtToken = preferences.getString('jwtToken') ?? '';
    final api = 'https://shopping-app-backend-t4ay.onrender.com/user/changePassword';
    final data = {
      "newPass" : newPass,
      "confirmPass" : confirmPass,
    };
    final header = {
      "Authorization" : 'Bearer $jwtToken'
    };

    var response = await http.post(Uri.parse(api), body: data, headers: header);
    if(response.statusCode == 200){
      var responsebody = jsonDecode(response.body);
      print(responsebody);
      emit(ChangePasswordSuccessState());
    }
    else if(response.statusCode == 400){
      emit(ChangePasswordFailedState());
      var responsebody = jsonDecode(response.body);
      print(responsebody);
    }
  }
}