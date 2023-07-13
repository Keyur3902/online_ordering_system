import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_ordering_system/BlocProject/cubit/BottomNavigation/screen/bottom_navigation_bloc.dart';
import 'package:online_ordering_system/BlocProject/cubit/Login/cubit/forgot_password_cubits.dart';
import 'package:online_ordering_system/BlocProject/cubit/Login/cubit/login_cubits.dart';
import 'package:online_ordering_system/BlocProject/cubit/Login/screen/forgot_password_screen_bloc.dart';
import 'package:online_ordering_system/BlocProject/cubit/Register/cubit/register_cubits.dart';
import 'package:online_ordering_system/BlocProject/cubit/Login/screen/login_screen_bloc.dart';
import '../cubit/Accounts/screen/account_screen_bloc.dart';
import '../cubit/Register/screen/register_screen_bloc.dart';

class Routes{

  static const String bottomNavigationBloc = 'bottomNavigationBloc';
  static const String cartPageBloc = 'cartPageBloc';
  static const String accountPageBloc = 'accountPageBloc';
  static const String authenticationOnForgotPass = 'authenticationOnForgotPass';
  static const String authenticationPageBloc = 'authenticationPageBloc';
  static const String favoritePageBloc = 'favoritePageBloc';
  static const String loginPageBloc = 'loginPageBloc';
  static const String productDetailsPageBloc = 'productDetailsPageBloc';
  static const String searchPageBloc = 'searchPageBloc';
  static const String registerPageBloc = 'registerPageBloc';
  static const String splashScreenBloc = 'splashScreenBloc';
  static const String forgotPasswordPageBloc = 'forgotPasswordPageBloc';
  static const String changePasswordPageBloc = 'changePasswordPageBloc';
  static const String orderHistoryPageBloc = 'orderHistoryPageBloc';
  static const String myAccountPageBloc = 'myAccountPageBloc';


  static Route? onGenerateRoute(RouteSettings settings){
    switch(settings.name){

      case Routes.bottomNavigationBloc:
        return MaterialPageRoute(builder: (context) => BottomNavigationBloc());
      case Routes.loginPageBloc:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => LoginCubit(),
            child: LoginScreenBloc(),
          ),
        );
      case Routes.registerPageBloc:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => RegisterCubit(),
            child: RegisterScreenBloc(),
          ),
        );
      case Routes.forgotPasswordPageBloc:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ForgotPasswordCubit(),
            child: ForgotPasswordPageBloc(),
          ),
        );
      case Routes.accountPageBloc:
        return MaterialPageRoute(
          builder: (context) => AccountScreenBloc(),
        );

    }
  }

}