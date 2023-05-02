import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class SplashScreenGet extends StatefulWidget {
  const SplashScreenGet({Key? key}) : super(key: key);

  @override
  State<SplashScreenGet> createState() => _SplashScreenGetState();
}

class _SplashScreenGetState extends State<SplashScreenGet> {
  void isLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getBool('isLogin') == true || preferences.getBool('isLogin') == null) {
      Timer(
          Duration(seconds: 2),
              () => Get.toNamed('/BottomNavigationGet')
      );
    } else {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF7F3F0),
        body: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/ShoppingSplash.png'),
                      fit: BoxFit.contain),
                ),
                child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'e'.tr,
                        style: TextStyle(
                          fontSize: 35,
                          fontFamily: 'NotoSans',
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(240, 240, 109, 86),
                        ),
                      ),
                      Text(
                        'shop'.tr,
                        style: TextStyle(
                          fontSize: 35,
                          fontFamily: 'NotoSans',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
