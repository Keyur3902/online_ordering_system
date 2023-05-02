import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:online_ordering_system/GetxProject/ViewGetx/accountSettingPage_get.dart';
import 'package:online_ordering_system/GetxProject/ViewGetx/cartPage_get.dart';
import 'package:online_ordering_system/GetxProject/ViewGetx/favotitePage_get.dart';
import 'package:online_ordering_system/GetxProject/ViewGetx/productList_get.dart';
import '../../notificationservices/local_notification_service.dart';
import 'orderHistory_get.dart';

class BottomNavigationGet extends StatefulWidget {
  const BottomNavigationGet({Key? key}) : super(key: key);

  @override
  State<BottomNavigationGet> createState() => _BottomNavigationGetState();
}

class _BottomNavigationGetState extends State<BottomNavigationGet> {

  StreamSubscription? internetConnection;
  bool isOffline = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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

    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method
    FirebaseMessaging.instance.getInitialMessage().then(
          (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
          (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
          (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    internetConnection!.cancel();
  }

  int _selectedIndex = 0;
  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
      print(_selectedIndex);
    });
  }

  final List<Widget> _pages = [
    ProductListGet(),
    OrderHistoryPageGet(),
    CartPageGet(),
    FavoritePageGet(),
    AccountSettingPageGet(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
            tabActiveBorder: Border.all(
              color: Color.fromARGB(240, 240, 109, 86),
            ),
            tabBorderRadius: 15,
            activeColor: Color.fromARGB(240, 240, 109, 86),
            padding: EdgeInsets.all(12),
            gap: 8,
            onTabChange: _navigateBottomBar,
            color: Colors.grey,
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home'.tr,
              ),
              GButton(
                icon: Icons.history,
                text: 'History'.tr,
              ),
              GButton(
                icon: Icons.shopping_cart,
                text: 'Cart'.tr,
              ),
              GButton(
                icon: Icons.favorite_border,
                text: 'Favorite'.tr,
              ),
              GButton(
                icon: Icons.account_circle_rounded,
                text: 'Accounts'.tr,
              )
            ],
          ),
        ),
      ),
    );
  }
}
