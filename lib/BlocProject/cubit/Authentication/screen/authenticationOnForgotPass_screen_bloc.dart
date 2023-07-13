import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:online_ordering_system/BlocProject/cubit/Authentication/cubit/authenticationOnForgotPass_cubits.dart';
import 'package:online_ordering_system/BlocProject/cubit/Authentication/state/authenticationOnForgotPass_states.dart';

import '../../../constants/routes.dart';

class AuthenticationOnForgorPassScreenBloc extends StatefulWidget {
  AuthenticationOnForgorPassScreenBloc({Key? key, required this.userId}) : super(key: key);

  final String userId;

  @override
  State<AuthenticationOnForgorPassScreenBloc> createState() => _AuthenticationOnForgorPassScreenBlocState();
}

class _AuthenticationOnForgorPassScreenBlocState extends State<AuthenticationOnForgorPassScreenBloc> {
  late String otpValue;
  bool _isResendAgain = false;
  late Timer _timer;
  int _start = 60;
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
                      BlocConsumer<AuthenticationOnForgotPassCubit,AuthenticationOnForgotPassState>(
                        listener: (context, state){
                          if(state is AuthenticationResendOtpState){
                            setState(() {
                              _isResendAgain = true;
                            });

                            const oneSec = Duration(seconds: 1);
                            _timer = Timer.periodic(oneSec, (timer) {
                              setState(() {
                                if (_start == 0) {
                                  _start = 60;
                                  _isResendAgain = false;
                                  timer.cancel();
                                } else {
                                  _start--;
                                }
                              });
                            });
                          }
                        },
                        builder: (context, state) {
                          return TextButton(
                            onPressed: (){
                              print("id");
                              if (_isResendAgain) return;
                              // resendOtp(arguments.toString());
                              BlocProvider.of<AuthenticationOnForgotPassCubit>(context).resendOtp(widget.userId);
                            },
                            child: _isResendAgain ? Text(
                              "${'Try again in'} $_start",
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
                  BlocConsumer<AuthenticationOnForgotPassCubit, AuthenticationOnForgotPassState>(
                    listener: (context, state){
                      if(state is AuthenticationOnForgotPassSuccessState) {
                        Navigator.of(context).pushNamed(Routes.loginPageBloc);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('OTP Verified Successfully And password sent to your Mail!')));
                      }
                      else if(state is AuthenticationOnForgotPassFailedState){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid OTP!')));
                      }
                    },
                    builder: (context, state) {
                      if(state is AuthenticationOnForgotPassLoadingState){
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
                            // authentication(arguments.toString(), otpValue.toString());
                            BlocProvider.of<AuthenticationOnForgotPassCubit>(context).authentication(widget.userId, otpValue.toString());
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
