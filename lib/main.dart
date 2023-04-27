import 'dart:developer';
import 'dart:ui';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:online_ordering_system/GetxProject/mainGet.dart';
import 'package:online_ordering_system/Screens/accountSettingPage.dart';
import 'package:online_ordering_system/Screens/authentication.dart';
import 'package:online_ordering_system/Screens/authenticationOnForgotPass.dart';
import 'package:online_ordering_system/Screens/bottomNavigationBar.dart';
import 'package:online_ordering_system/Screens/cartPage.dart';
import 'package:online_ordering_system/Screens/changePasswordPage.dart';
import 'package:online_ordering_system/Screens/forgotPasswordPage.dart';
import 'package:online_ordering_system/Screens/favoritePage.dart';
import 'package:online_ordering_system/Screens/login.dart';
import 'package:online_ordering_system/Screens/myAccountPage.dart';
import 'package:online_ordering_system/Screens/orderHistoryPage.dart';
import 'package:online_ordering_system/Screens/productDetailsPage.dart';
import 'package:online_ordering_system/Screens/searchPage.dart';
import 'package:online_ordering_system/Screens/signUp.dart';
import 'package:online_ordering_system/Screens/spalshScreen.dart';
import 'package:online_ordering_system/notificationservices/local_notification_service.dart';
import 'package:online_ordering_system/provider/cartProvider.dart';
import 'package:online_ordering_system/provider/cloudMessangingProvider.dart';
import 'package:online_ordering_system/provider/favoriteProvider.dart';
import 'package:online_ordering_system/provider/orderListProvider.dart';
import 'package:online_ordering_system/provider/productProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
/*  print(message.data.toString());
  print(message.notification!.title);*/
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FlutterError.onError = (errorDetails) {
    // If you wish to record a "non-fatal" exception, please use `FirebaseCrashlytics.instance.recordFlutterError` instead
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    // If you wish to record a "non-fatal" exception, please remove the "fatal" parameter
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  if (DefaultFirebaseOptions.currentPlatform == DefaultFirebaseOptions.ios) {
  } else {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
    LocalNotificationService.initialize();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('fcmToken', fcmToken!);
    log(fcmToken);

  }
// runApp(const MyApp());
runApp(const GetApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => Favorite()),
        ChangeNotifierProvider(create: (_) => OrderList()),
        ChangeNotifierProvider(create: (_) => GetProductProvider()),
        ChangeNotifierProvider(create: (_) => FirebaseApiCalling())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        initialRoute: '/SplashScreen',
        routes: {
          '/CartPage': (_) => CartPage(),
          '/AccountPage': (_) => AccountSettingPage(),
          '/AuthenticationPage': (_) => Authentication(),
          '/BottomNavigation': (_) => BottomNavigationBarPage(),
          '/FavoritePage': (_) => FavoritePage(),
          '/LoginPage': (_) => LogIn(),
          '/ProductDetailsPage': (_) => ProductDetailsPage(),
          '/SearchPage': (_) => SearchPage(),
          '/SignUpPage': (_) => SignUp(),
          '/SplashScreen': (_) => SplashScreen(),
          '/ForgotPasswordPage': (_) => ForgotPassword(),
          '/ChangePasswordPage' : (_) => ChangePassword(),
          '/OrderHistoryPage' : (_) => OrderHistory(),
          '/MyAccountPage' : (_) => MyAccountPage(),
          '/AuthenticationOnForgotPass' : (_) => AuthenticationOnForgotPass(),
        },
      ),
    );
  }
}