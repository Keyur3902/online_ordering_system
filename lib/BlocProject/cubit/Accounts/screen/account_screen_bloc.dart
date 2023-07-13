import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_ordering_system/BlocProject/cubit/Accounts/cubit/change_password_cubit.dart';
import 'package:online_ordering_system/BlocProject/cubit/Accounts/screen/change_password_screen_bloc.dart';
import 'package:online_ordering_system/BlocProject/cubit/Accounts/screen/my_account_screen_bloc.dart';
import 'package:online_ordering_system/BlocProject/cubit/OrderHistory/cubit/order_history_cubit.dart';
import 'package:online_ordering_system/BlocProject/cubit/OrderHistory/screen/order_history_screen_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/routes.dart';

class AccountScreenBloc extends StatelessWidget {
  const AccountScreenBloc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Color(0xffF0F0F1),
          child: Column(
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/ShoppingSplash.png'),
                            fit: BoxFit.cover,
                          ),
                          shape: BoxShape.circle,
                        ),
                        height: 30,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello,',
                            style: TextStyle(
                                fontFamily: 'NotoSans',
                                color: Colors.grey,
                                fontSize: 15
                            ),
                          ),
                          Text(
                            'Welcome to eshop',
                            style: TextStyle(
                              fontFamily: 'NotoSans',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(top: 10, left: 15, right: 15),
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))
                      ),
                      child: ListTile(
                        leading: Icon(Icons.account_circle_rounded,),
                        title: Text(
                          'My Account',
                          style: TextStyle(
                              fontFamily: 'NotoSans'
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.arrow_forward_ios),
                          iconSize: 15,
                          onPressed: () async {
                            SharedPreferences preferences = await SharedPreferences.getInstance();
                            String mail = preferences.getString('emailId').toString();
                            String name = preferences.getString('name').toString();
                            String mobileNo = preferences.getString('mobileNo').toString();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MyAccountScreenBloc(name: name, email: mail, phoneNo: mobileNo)));
                          },
                        ),
                      ),
                    ),
                    Container(height: 1, color: Color(0xffF0F0F1)),
                    Container(
                      color: Colors.white,
                      child: ListTile(
                        leading: Icon(Icons.history,),
                        tileColor: Colors.white,
                        title: Text(
                          'Order History',
                          style: TextStyle(
                              fontFamily: 'NotoSans'
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.arrow_forward_ios),
                          iconSize: 15,
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider<OrderHistoryCubit>(
                              child: OrderHistoryScreenBloc(),
                              create: (context) {
                                return OrderHistoryCubit();
                              }
                            )));
                          },
                        ),
                      ),
                    ),
                    Container(height: 1, color: Color(0xffF0F0F1)),
                    Container(
                      color: Colors.white,
                      child: ListTile(
                        leading: Icon(Icons.password,),
                        tileColor: Colors.white,
                        title: Text(
                          'Change Password',
                          style: TextStyle(
                              fontFamily: 'NotoSans'
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.arrow_forward_ios),
                          iconSize: 15,
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider<ChangePasswordCubit>(
                                child: ChangePasswordScreenBloc(),
                                create: (context) {
                                  return ChangePasswordCubit();
                                }
                            )));
                          },
                        ),
                      ),
                    ),
                    Container(height: 1, color: Color(0xffF0F0F1)),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))
                      ),
                      child: ListTile(
                        leading: Icon(Icons.logout_outlined,),
                        tileColor: Colors.white,
                        title: Text(
                          'Log Out',
                          style: TextStyle(
                              fontFamily: 'NotoSans'
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.arrow_forward_ios),
                          iconSize: 15,
                          onPressed: () async {
                            SharedPreferences preferences = await SharedPreferences.getInstance();
                            preferences.clear();
                            Navigator.pushNamedAndRemoveUntil(context, Routes.loginPageBloc, (route) => false);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
