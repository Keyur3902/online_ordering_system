import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:online_ordering_system/Data/validation.dart';
import 'package:online_ordering_system/GetxProject/ControllerGetx/authControllerGext.dart';
import 'package:online_ordering_system/Screens/login.dart';
import 'package:get/get.dart';

class SignUpPageGet extends StatelessWidget {
  SignUpPageGet({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return SafeArea(
      child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: SingleChildScrollView(
              child: GetBuilder<AuthControllerGet>(
                init: AuthControllerGet(),
                builder: (context) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        Text(
                          'Create a new account'.tr,
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'NotoSans',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Please put your information below to crete a new account for using our app.'.tr,
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'NotoSans',
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter some text'.tr;
                            }
                          },
                          controller: nameController,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffF0F0F1),
                              icon: Icon(Icons.person_sharp),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'Full Name'.tr,
                              hintStyle: TextStyle(
                                fontFamily: 'NotoSans',
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter some text'.tr;
                            } else if (!Validation.validateEmail(value)) {
                              return 'please enter valid email'.tr;
                            } else {
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
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter some text'.tr;
                            } else if (!Validation.validatePhone(value)) {
                              return 'please enter valid phone no.'.tr;
                            } else {
                              return null;
                            }
                          },
                          controller: mobileNoController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffF0F0F1),
                            hintText: 'Phone No.'.tr,
                            hintStyle: TextStyle(
                              fontFamily: 'NotoSans',
                            ),
                            icon: Icon(Icons.phone),
                            focusColor: Colors.grey,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter some text'.tr;
                            } else {
                              return null;
                            }
                          },
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffF0F0F1),
                            icon: Icon(Icons.password),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Password'.tr,
                            hintStyle: TextStyle(
                              fontFamily: 'NotoSans',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter some text'.tr;
                            } else if (value != passwordController.text) {
                              return 'password not match'.tr;
                            } else {
                              return null;
                            }
                          },
                          obscureText: true,
                          controller: rePasswordController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffF0F0F1),
                            icon: Icon(Icons.password),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Re-enter Password'.tr,
                            hintStyle: TextStyle(
                              fontFamily: 'NotoSans',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              context.register(nameController.text, mobileNoController.text,
                                  emailController.text, passwordController.text);
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Register Now'.tr,
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
                              )),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?'.tr,
                              style: TextStyle(
                                fontFamily: 'NotoSans',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.toNamed('/LoginPageGet');
                              },
                              child: Text(
                                'Join now'.tr,
                                style: TextStyle(
                                    color: Color.fromARGB(240, 240, 109, 86),
                                    fontFamily: 'NotoSans',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
              ),
            ),
          )),
    );
  }
}
