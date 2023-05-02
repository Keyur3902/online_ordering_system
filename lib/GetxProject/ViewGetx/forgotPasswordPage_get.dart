import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:online_ordering_system/Data/validation.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ForgotPasswordPageGet extends StatefulWidget {
  const ForgotPasswordPageGet({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPageGet> createState() => _ForgotPasswordPageGetState();
}

class _ForgotPasswordPageGetState extends State<ForgotPasswordPageGet> {
  String? userId;

  void forgotPassword(String emailId) async {
    final api = 'https://shopping-app-backend-t4ay.onrender.com/user/forgotPassword';

    final data = {
      "emailId" : emailId,
    };
    var response = await http.post(Uri.parse(api), body: data);

    if(response.statusCode == 200){
      var responsebody = jsonDecode(response.body);
      print(responsebody);
      userId = responsebody['data']['_id'];
      Get.snackbar('eshop'.tr, 'Please verify otp sent to your email!'.tr, snackPosition: SnackPosition.BOTTOM, margin: EdgeInsets.only(left: 10, right: 10, bottom: 10));
      Get.toNamed('/OtpOnForgotPasswordPageGet', arguments: userId);
    }
    else if(response.statusCode == 400){
      Get.snackbar('eshop'.tr, 'This Email Id is not Registered With us kindly register first!'.tr, snackPosition: SnackPosition.BOTTOM, margin: EdgeInsets.only(left: 10, right: 10, bottom: 10));
      var responsebody = jsonDecode(response.body);
      print(responsebody);
    }
  }

  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
                      'Recover your Password'.tr,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'NotoSans',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Your password is sent to your registered phone no. or email you enter here.'.tr,
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'NotoSans',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return 'please enter some text'.tr;
                      }
                      else if(!Validation.validateEmail(value)){
                        return 'please enter valid email'.tr;
                      }
                      else{
                        return null;
                      }
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xffF0F0F1),
                      icon: Icon(Icons.mail),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),

                      hintText: 'E - Mail'.tr,
                      hintStyle: TextStyle(
                        fontFamily: 'NotoSans',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                        forgotPassword(emailController.text);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Recover'.tr,
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      backgroundColor: Color.fromARGB(240, 240, 109, 86),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
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
