import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:online_ordering_system/GetxProject/ViewGetx/accountSettingPage_get.dart';
import 'package:online_ordering_system/GetxProject/ViewGetx/cartPage_get.dart';
import 'package:online_ordering_system/GetxProject/ViewGetx/favotitePage_get.dart';
import 'package:online_ordering_system/GetxProject/ViewGetx/productList_get.dart';
import 'orderHistory_get.dart';

class BottomNavigationGet extends StatefulWidget {
  const BottomNavigationGet({Key? key}) : super(key: key);

  @override
  State<BottomNavigationGet> createState() => _BottomNavigationGetState();
}

class _BottomNavigationGetState extends State<BottomNavigationGet> {

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
                text: 'Home',
              ),
              GButton(
                icon: Icons.history,
                text: 'History',
              ),
              GButton(
                icon: Icons.shopping_cart,
                text: 'Cart',
              ),
              GButton(
                icon: Icons.favorite_border,
                text: 'Favorite',
              ),
              GButton(
                icon: Icons.account_circle_rounded,
                text: 'Accounts',
              )
            ],
          ),
        ),
      ),
    );
  }
}
