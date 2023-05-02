import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class AccountSettingPageGet extends StatefulWidget {
  const AccountSettingPageGet({Key? key}) : super(key: key);

  @override
  State<AccountSettingPageGet> createState() => _AccountSettingPageGetState();
}

class _AccountSettingPageGetState extends State<AccountSettingPageGet> {
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
                            'Hello,'.tr,
                            style: TextStyle(
                                fontFamily: 'NotoSans',
                                color: Colors.grey,
                                fontSize: 15
                            ),
                          ),
                          Text(
                            'Welcome to eshop'.tr,
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
                          'My Profile'.tr,
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
                            Get.toNamed('/MyAccountPageGet', arguments: {'args1' : mail, 'args2': name, 'args3' : mobileNo});
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
                          'Order History'.tr,
                          style: TextStyle(
                              fontFamily: 'NotoSans'
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.arrow_forward_ios),
                          iconSize: 15,
                          onPressed: (){
                            Get.toNamed('/OrderHistoryPageGet');
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
                          'Change Password'.tr,
                          style: TextStyle(
                              fontFamily: 'NotoSans'
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.arrow_forward_ios),
                          iconSize: 15,
                          onPressed: (){
                            Get.toNamed('/ChangePasswordPageGet');
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
                          'Log Out'.tr,
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
                            Get.offNamedUntil('/LoginPageGet', (route) => false);
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