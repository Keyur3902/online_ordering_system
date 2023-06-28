import 'package:flutter/material.dart';
import 'package:online_ordering_system/GetxProject/ViewGetx/changePasswordPage_get.dart';
import 'package:online_ordering_system/GetxProject/ViewGetx/forgotPasswordPage_get.dart';
import 'package:online_ordering_system/GetxProject/ViewGetx/loginPage_get.dart';
import 'package:online_ordering_system/GetxProject/ViewGetx/myAccountPage_get.dart';
import 'package:online_ordering_system/GetxProject/ViewGetx/otpOnForgotPassword_get.dart';
import 'package:online_ordering_system/GetxProject/ViewGetx/otpOnRegister_get.dart';
import 'package:online_ordering_system/GetxProject/ViewGetx/registerPage_get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ViewGetx/productDetailsPage_get.dart';
import 'ViewGetx/accountSettingPage_get.dart';
import 'ViewGetx/bottomNavigation_get.dart';
import 'ViewGetx/cartPage_get.dart';
import 'ViewGetx/favotitePage_get.dart';
import 'ViewGetx/orderHistory_get.dart';
import 'ViewGetx/productList_get.dart';
import 'ViewGetx/splashScreen_get.dart';
import 'package:get/get.dart';

import 'localeString.dart';

class GetApp extends StatefulWidget {
  const GetApp({Key? key}) : super(key: key);

  @override
  State<GetApp> createState() => _GetAppState();
}

class _GetAppState extends State<GetApp> {

  Map<String, String> _locale = {'languageCode' : '', 'countryCode' : ''};

  Future<Map<String, String>> getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return{
      'languageCode' : preferences.getString('language') ?? 'en',
      'countryCode' : preferences.getString('country') ?? 'US'
    };
  }
  @override
  void initState() {
    // TODO: implement initState
    getPref().then((value) {
      setState(() {
        _locale = value;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: LocaleString(),
      locale: Locale(_locale['languageCode']!, _locale['countryCode']),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreenGet(),
      getPages: [
        GetPage(name: '/', page: () => SplashScreenGet()),
        GetPage(name: '/BottomNavigationGet', page: () => BottomNavigationGet()),
        GetPage(name: '/AccountSettingPageGet', page: () => AccountSettingPageGet()),
        GetPage(name: '/CartPageGet', page: () => CartPageGet()),
        GetPage(name: '/OrderHistoryPageGet', page: () => OrderHistoryPageGet()),
        GetPage(name: '/FavoritePageGet', page: () => FavoritePageGet()),
        GetPage(name: '/ProductListGet', page: () => ProductListGet()),
        GetPage(name: '/ProductDetailsPageGet', page: () => ProductDetailsPageGet()),
        GetPage(name: '/MyAccountPageGet', page: () => MyAccountPageGet()),
        GetPage(name: '/ChangePasswordPageGet', page: () => ChangePasswordPageGet()),
        GetPage(name: '/LoginPageGet', page: () => LoginPageGet()),
        GetPage(name: '/SignUpPageGet', page: () => SignUpPageGet()),
        GetPage(name: '/OtpOnRegisterPageGet', page: () => OtpOnRegisterGet()),
        GetPage(name: '/ForgotPasswordPageGet', page: () => ForgotPasswordPageGet()),
        GetPage(name: '/OtpOnForgotPasswordPageGet', page: () => OtpOnForgotPasswordPageGet()),
      ],
    );
  }
}
