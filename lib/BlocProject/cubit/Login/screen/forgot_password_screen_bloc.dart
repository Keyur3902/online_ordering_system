import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:online_ordering_system/BlocProject/cubit/Authentication/cubit/authenticationOnForgotPass_cubits.dart';
import 'package:online_ordering_system/BlocProject/cubit/Login/state/forgot_password_state.dart';
import 'package:online_ordering_system/Screens/authenticationOnForgotPass.dart';

import '../../../../Data/validation.dart';
import '../../Authentication/screen/authenticationOnForgotPass_screen_bloc.dart';
import '../cubit/forgot_password_cubits.dart';

class ForgotPasswordPageBloc extends StatelessWidget {
  ForgotPasswordPageBloc({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                      'Recover your Password',
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
                      'Your password is sent to your registered phone no. or email you enter here.',
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
                      else if(!Validation.validateEmail(value)){
                        return 'please enter valid email';
                      }
                      else{
                        return null;
                      }
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xffF0F0F1),
                      icon: Icon(Icons.mail),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),

                      hintText: 'E - Mail',
                      hintStyle: TextStyle(
                        fontFamily: 'NotoSans',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
                    listener: (context, state){
                      if(state is ForgotPasswordSuccessState){
                        String? userId = BlocProvider.of<ForgotPasswordCubit>(context).userId;
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please verify otp sent to your email!')));
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => BlocProvider(
                          create: (context) => AuthenticationOnForgotPassCubit(),
                          child: AuthenticationOnForgorPassScreenBloc(userId: userId!,),
                        )));
                      }
                      else if(state is ForgotPasswordFailedState){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('This Email Id is not Registered With us kindly register first!')));
                      }
                    },
                    builder: (context, state) {
                      if(state is ForgotPasswordLoadingState){
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
                            BlocProvider.of<ForgotPasswordCubit>(context).forgotPassword(emailController.text);
                            // forgotPassword(emailController.text);
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Recover',
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
