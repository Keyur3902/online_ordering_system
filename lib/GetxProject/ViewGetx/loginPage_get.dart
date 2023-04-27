import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../../Data/validation.dart';

class LoginPageGet extends StatefulWidget {
  const LoginPageGet({Key? key}) : super(key: key);

  @override
  State<LoginPageGet> createState() => _LoginPageGetState();
}

class _LoginPageGetState extends State<LoginPageGet> {

  final _formKey = GlobalKey<FormState>();
  StreamSubscription? internetConnection;
  bool isOffline = false;

  void initState() {
    // TODO: implement initState
    super.initState();
    // void permission() async {
    //   if (await Permission.notification.status != PermissionStatus.granted) {
    //     await Permission.notification.request();
    //   }
    // }

    internetConnection = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(result == ConnectivityResult.none){
        setState(() {
          isOffline = true;
        });
      }
      else if(result == ConnectivityResult.mobile){
        setState(() {
          isOffline = false;
        });
      }
      else if(result == ConnectivityResult.wifi){
        setState(() {
          isOffline = false;
        });
      }
    });
  }

  // SnackBar snackBar  = SnackBar(content: Text('Invalid username or password!'));

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
        'Error!!!', 'Invalid username or password!', margin: EdgeInsets.only(
          bottom: 10,
          left: 10,
          right: 15)
      );
      print(responseBody1);
    }
    else{
      Get.snackbar(
          'Error!!!', 'Invalid username or password!', margin: EdgeInsets.only(
          bottom: 10,
          left: 10,
          right: 15)
      );
      Get.offNamedUntil('/LoginPageGet', (route) => false);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    internetConnection!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return SafeArea(
      child: isOffline ? Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/wireless.png'),
              SizedBox(height: 10,),
              Text(
                'Oops!! No Internet Connection',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NotoSans'
                ),
              ),
            ],
          ),
        ),
      ) : Scaffold(
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
                                text: 'e',
                                style: TextStyle(
                                  color: Color.fromARGB(240, 240, 109, 86),
                                ),
                              ),
                              TextSpan(
                                text: 'shop',
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
                    child: RichText(
                      text: TextSpan(
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: 'Welcome to ',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: 'e',
                              style: TextStyle(
                                color: Color.fromARGB(240, 240, 109, 86),
                              ),
                            ),
                            TextSpan(
                              text: 'Shop',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Please enter your email below to start using app.',
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
                        return 'please enter some text';
                      }
                      else if(!Validation.validateEmail(value)){
                        return 'please enter valid email';
                      }
                      else{
                        return null;
                      }
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffF0F0F1),
                        icon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          fontFamily: 'NotoSans',
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return 'please enter some text';
                      }
                      else{
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
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        fontFamily: 'NotoSans',
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: (){
                        Get.toNamed('/ForgotPasswordPageGet');
                      },
                      child: Text('Forgot password?',
                        style: TextStyle(
                          color: Color.fromARGB(240, 240, 109, 86),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                        login(emailController.text, passwordController.text);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sign in',
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
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style: TextStyle(
                          fontFamily: 'NotoSans',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.offNamed('/SignUpPageGet');
                        },
                        child: Text(
                          'Join now',
                          style: TextStyle(
                            color: Color.fromARGB(240, 240, 109, 86),
                            fontFamily: 'NotoSans',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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
