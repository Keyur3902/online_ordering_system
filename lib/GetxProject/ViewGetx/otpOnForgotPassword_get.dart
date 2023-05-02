import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class OtpOnForgotPasswordPageGet extends StatefulWidget {
  const OtpOnForgotPasswordPageGet({Key? key}) : super(key: key);

  @override
  State<OtpOnForgotPasswordPageGet> createState() => _OtpOnForgotPasswordPageGetState();
}

class _OtpOnForgotPasswordPageGetState extends State<OtpOnForgotPasswordPageGet> {
  late String otpValue;
  bool _isResendAgain = false;
  late Timer _timer;
  int _start = 60;
  String arguments = '';
  final _formKey = GlobalKey<FormState>();

  void resendOtp(String userId) async {
    final api = 'https://shopping-app-backend-t4ay.onrender.com/user/resendOtp';
    final data = {
      "userId": userId,
    };
    var response = await http.post(Uri.parse(api), body: data);

    if(response.statusCode == 200){
      var responsebody = jsonDecode(response.body);
      print(responsebody);

      setState(() {
        _isResendAgain = true;
      });

      const oneSec = Duration(seconds: 1);
      _timer = Timer.periodic(oneSec, (timer) {
        setState(() {
          if (_start == 0) {
            _start = 60;
            _isResendAgain = false;
            timer.cancel();
          } else {
            _start--;
          }
        });
      });
    }
  }

  void authentication(
      String userId, String otp) async {
    final api =
        'https://shopping-app-backend-t4ay.onrender.com/user/verifyOtpOnForgotPassword';
    final data = {
      "userId": userId,
      "otp": otp,
    };
    var response = await http.post(Uri.parse(api), body: data);

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      print(responseBody);
      Get.snackbar('eshop'.tr, 'OTP Verified Successfully And password sent to your Mail!'.tr, snackPosition: SnackPosition.BOTTOM, margin: EdgeInsets.only(left: 10, right: 10, bottom: 10));
      Get.toNamed('/LoginPageGet');

    } else if(response.statusCode == 400){
      Get.snackbar('eshop'.tr, 'Invalid OTP!'.tr, snackPosition: SnackPosition.BOTTOM, margin: EdgeInsets.only(left: 10, right: 10, bottom: 10));
      var responseBody1 = jsonDecode(response.body);
      print(responseBody1);
    }
  }

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context)!.settings.arguments as String;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 10),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/ShoppingSplash.png'),
                            ),
                            shape: BoxShape.circle,
                          ),
                          height: 100,
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 35,
                              fontFamily: 'NotoSans',
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: 'e'.tr,
                                style: TextStyle(
                                  color: Color.fromARGB(240, 240, 109, 86),
                                ),
                              ),
                              TextSpan(
                                text: 'shop'.tr,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'OTP Authentication'.tr,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          fontFamily: 'NotoSans'
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Text(
                    'An Authentication code has been send to Example@gmail.com'.tr,
                    style: TextStyle(
                      fontFamily: 'NotoSans',
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 18,),
                  OtpTextField(
                    onSubmit: (String value){
                      otpValue = value;
                    },
                    numberOfFields: 4,
                    showFieldAsBox: true,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    focusedBorderColor: Colors.grey,
                    fieldWidth: 70,
                    borderRadius: BorderRadius.circular(8),
                    borderWidth: 3,
                    cursorColor: Color.fromARGB(240, 240, 109, 86),
                    filled: true,
                    fillColor: Color(0xffF0F0F1),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 12,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Didn\'t receive the code?'.tr,
                        style: TextStyle(
                          fontFamily: 'NotoSans',
                          color: Colors.grey,
                        ),
                      ),
                      TextButton(
                        onPressed: (){
                          print("id");
                          if (_isResendAgain) return;
                          resendOtp(arguments.toString());
                        },
                        child: _isResendAgain ? Text(
                          "${'Try again in'.tr} $_start",
                          style: TextStyle(
                            color: Color.fromARGB(240, 240, 109, 86),
                          ),
                        ) : Text(
                          'Resend'.tr,
                          style: TextStyle(
                            color: Color.fromARGB(240, 240, 109, 86),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        authentication(arguments.toString(), otpValue.toString());
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Continue'.tr,style: TextStyle(fontFamily: 'NotoSans',),),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        backgroundColor: Color.fromARGB(240, 240, 109, 86),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
