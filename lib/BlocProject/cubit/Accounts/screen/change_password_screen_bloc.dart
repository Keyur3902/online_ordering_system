import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:online_ordering_system/BlocProject/cubit/Accounts/cubit/change_password_cubit.dart';
import 'package:online_ordering_system/BlocProject/cubit/Accounts/state/change_password_state.dart';

import '../../../constants/routes.dart';

class ChangePasswordScreenBloc extends StatelessWidget {
  ChangePasswordScreenBloc({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  TextEditingController pass = TextEditingController();
  TextEditingController rePass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 10),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/ShoppingSplash.png'),
                            ),
                            shape: BoxShape.circle,
                          ),
                          height: 100,
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 35,
                              fontFamily: 'NotoSans',
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: 'e',
                                style: TextStyle(
                                  color: Color.fromARGB(240, 240, 109, 86),
                                ),
                              ),
                              TextSpan(
                                text: 'shop',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Change your Password',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'NotoSans',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Your new password must be different form your previous password.',
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'NotoSans',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return 'please enter some text';
                      }
                      else{
                        return null;
                      }
                    },
                    controller: pass,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xffF0F0F1),
                      icon: Icon(Icons.password),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'New password',
                      hintStyle: TextStyle(
                        fontFamily: 'NotoSans',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return 'please enter some text';
                      }
                      else if(value != pass.text){
                        return "password doesn't match";
                      }
                      else{
                        return null;
                      }
                    },
                    controller: rePass,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xffF0F0F1),
                      icon: Icon(Icons.password),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Re-enter new password',
                      hintStyle: TextStyle(
                        fontFamily: 'NotoSans',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
                    listener: (context, state) {
                      if(state is ChangePasswordSuccessState){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Your Password Changed Successfully!')));
                        Navigator.pushNamedAndRemoveUntil(context, Routes.loginPageBloc, (route) => false);
                      }
                      else if(state is ChangePasswordFailedState){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Your Password Changes Failed!')));
                      }
                    },
                    builder: (context, state) {
                      if(state is ChangePasswordLoadingState){
                        return Center(
                          child: SpinKitSpinningLines(
                            color: Color.fromARGB(240, 240, 109, 86),
                            size: 50.0,
                          ),
                        );
                      }
                      return ElevatedButton(
                        onPressed: () {
                          if(_formKey.currentState!.validate()){
                            // changePassword(pass.text, rePass.text);
                            BlocProvider.of<ChangePasswordCubit>(context).changePassword(pass.text, rePass.text);
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Change',
                              style: TextStyle(
                                fontFamily: 'NotoSans',
                              ),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.only(top: 15, bottom: 15),
                          backgroundColor: Color.fromARGB(240, 240, 109, 86),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    }
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
