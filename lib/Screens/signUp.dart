import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:online_ordering_system/Data/validation.dart';
import 'package:online_ordering_system/Screens/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  SnackBar snackBar = SnackBar(
      content: Text('Email already registered!! try using another EmailId'));
  String? userId;

  void register(
      String name, String mobileNo, String emailId, String password) async {
    final api =
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
      SnackBar snackBar1 = SnackBar(content: Text('Please verify OTP sent to your mail!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar1);
      Navigator.pushNamed(context, '/AuthenticationPage', arguments: userId);
    } else if (response.statusCode == 400) {
      var responseBody1 = jsonDecode(response.body);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print(responseBody1);
    }
  }

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
          child: Form(
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
                Text(
                  'Create a new account',
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
                  'Please put your information below to crete a new account for using our app.',
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
                      return 'please enter some text';
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
                      hintText: 'Full Name',
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
                      return 'please enter some text';
                    } else if (!Validation.validateEmail(value)) {
                      return 'please enter valid email';
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
                      hintText: 'Email',
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
                      return 'please enter some text';
                    } else if (!Validation.validatePhone(value)) {
                      return 'please enter valid phone no.';
                    } else {
                      return null;
                    }
                  },
                  controller: mobileNoController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffF0F0F1),
                    hintText: 'Phone No.',
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
                      return 'please enter some text';
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
                    hintText: 'Password',
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
                      return 'please enter some text';
                    } else if (value != passwordController.text) {
                      return 'password not match';
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
                    hintText: 'Re-enter Password',
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
                      register(nameController.text, mobileNoController.text,
                          emailController.text, passwordController.text);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Register Now',
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
                      'Already have an account?',
                      style: TextStyle(
                        fontFamily: 'NotoSans',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => LogIn()),
                        );
                      },
                      child: Text(
                        'Join now',
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
          ),
        ),
      )),
    );
  }
}
