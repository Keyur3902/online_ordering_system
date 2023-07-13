import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:online_ordering_system/BlocProject/cubit/Authentication/cubit/authentication_cubits.dart';
import 'package:online_ordering_system/BlocProject/cubit/Authentication/state/authentication_states.dart';

import '../../../constants/routes.dart';

class AuthenticationPageBloc extends StatefulWidget {
  AuthenticationPageBloc({Key? key, required this.userId}) : super(key: key);

  final String userId;

  @override
  State<AuthenticationPageBloc> createState() => _AuthenticationPageBlocState();
}

class _AuthenticationPageBlocState extends State<AuthenticationPageBloc> {
  late String otpValue;
  final _formKey = GlobalKey<FormState>();
  bool isResendAgain = false;
  int start = 60;
  late Timer timer;
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
                      'OTP Authentication',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          fontFamily: 'NotoSans'
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Text(
                    'An Authentication code has been send to Example@gmail.com',
                    style: TextStyle(
                      fontFamily: 'NotoSans',
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 18,),
                  OtpTextField(
                    onSubmit: (String value){
                      otpValue = value;
                    },
                    numberOfFields: 4,
                    showFieldAsBox: true,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    focusedBorderColor: Colors.grey,
                    fieldWidth: 70,
                    borderRadius: BorderRadius.circular(8),
                    borderWidth: 3,
                    cursorColor: Color.fromARGB(240, 240, 109, 86),
                    filled: true,
                    fillColor: Color(0xffF0F0F1),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 12,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Didn\'t receive the code?',
                        style: TextStyle(
                          fontFamily: 'NotoSans',
                          color: Colors.grey,
                        ),
                      ),
                      BlocConsumer<AuthenticationCubit, AuthenticationState>(
                        listener: (context, state){
                          if(state is ResendOtpState){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('OTP Resended Successfully')));
                            setState(() {
                              isResendAgain = true;
                            });
                            const oneSec = Duration(seconds: 1);
                            timer = Timer.periodic(oneSec, (timer) {
                              setState(() {
                                if (start == 0) {
                                  start = 60;
                                  isResendAgain = false;
                                  timer.cancel();
                                } else {
                                  start--;
                                }
                              });
                            });
                          }
                        },
                        builder: (context, state) {
                          return TextButton(
                            onPressed: (){
                              print("id");
                              if (isResendAgain) return;
                              // resendOtp(arguments.toString());
                              BlocProvider.of<AuthenticationCubit>(context).resendOtp(widget.userId);
                            },
                            child: isResendAgain ? Text(
                              "${'Try again in'} $start",
                              style: TextStyle(
                                color: Color.fromARGB(240, 240, 109, 86),
                              ),
                            ) : Text(
                              'Resend',
                              style: TextStyle(
                                color: Color.fromARGB(240, 240, 109, 86),
                              ),
                            ),
                          );
                        }
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  BlocConsumer<AuthenticationCubit, AuthenticationState>(
                    listener: (context, state) {
                      if(state is AuthenticationSuccessState){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('You have successfully registered!')));
                        Navigator.of(context).pushNamedAndRemoveUntil(Routes.loginPageBloc, (route) => false);
                      }
                      else if(state is AuthenticationFailedState){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid OTP!')));
                      }
                    },
                    builder: (context, state) {
                      if(state is AuthenticationLoadingState){
                        return Center(
                          child: SpinKitSpinningLines(
                            color: Color.fromARGB(240, 240, 109, 86),
                            size: 50.0,
                          ),
                        );
                      }

                      return ElevatedButton(
                        onPressed: (){
                          if(_formKey.currentState!.validate()){
                            // print(arguments.toString() + otpValue.toString());
                            // authentication(arguments.toString(), otpValue.toString());
                            BlocProvider.of<AuthenticationCubit>(context).authentication(widget.userId.toString(), otpValue.toString());
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Continue',style: TextStyle(fontFamily: 'NotoSans',),),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.only(top: 15, bottom: 15),
                            backgroundColor: Color.fromARGB(240, 240, 109, 86),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )
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
