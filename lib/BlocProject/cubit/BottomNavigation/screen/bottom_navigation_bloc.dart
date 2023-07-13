import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:online_ordering_system/BlocProject/cubit/Accounts/screen/account_screen_bloc.dart';
import 'package:online_ordering_system/BlocProject/cubit/Cart/cubit/cart_cubit.dart';
import 'package:online_ordering_system/BlocProject/cubit/Cart/screen/cart_screen_bloc.dart';
import 'package:online_ordering_system/BlocProject/cubit/Favourites/cubit/favourite_cubit.dart';
import 'package:online_ordering_system/BlocProject/cubit/Favourites/screen/favourite_screen_bloc.dart';
import 'package:online_ordering_system/BlocProject/cubit/OrderHistory/cubit/order_history_cubit.dart';
import 'package:online_ordering_system/BlocProject/cubit/OrderHistory/screen/order_history_screen_bloc.dart';
import 'package:online_ordering_system/BlocProject/cubit/ProductList/cubit/product_list_cubit.dart';
import 'package:online_ordering_system/BlocProject/cubit/ProductList/screen/product_list_screen_bloc.dart';

class BottomNavigationBloc extends StatefulWidget {
  BottomNavigationBloc({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBloc> createState() => _BottomNavigationBlocState();
}

class _BottomNavigationBlocState extends State<BottomNavigationBloc> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
      print(_selectedIndex);
    });
  }

  final List<Widget> _pages = [
    BlocProvider(
      child: ProductListScreenBloc(),
      create: (context) => ProductListCubit(),
    ),
    BlocProvider(
      create: (context) {
        return OrderHistoryCubit();
      },
      child: OrderHistoryScreenBloc(),
    ),
    BlocProvider(
      create: (context) => CartCubit(),
      child: CartScreenBloc(),
    ),
    BlocProvider(
      child: FavouriteScreenBloc(),
      create: (context) {
        return FavouriteCubit();
      }
    ),
    AccountScreenBloc(),
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
