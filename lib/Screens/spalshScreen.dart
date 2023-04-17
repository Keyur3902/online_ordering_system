import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void isLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getBool('isLogin') == true || preferences.getBool('isLogin') == null) {
      Timer(
          Duration(seconds: 2),
          () =>
              Navigator.of(context).pushReplacementNamed('/BottomNavigation'));
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
                        'e',
                        style: TextStyle(
                          fontSize: 35,
                          fontFamily: 'NotoSans',
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(240, 240, 109, 86),
                        ),
                      ),
                      Text(
                        'shop',
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
