import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:online_ordering_system/BlocProject/cubit/Login/cubit/login_cubits.dart';
import 'package:online_ordering_system/BlocProject/cubit/Login/state/login_states.dart';

import '../../../../Data/validation.dart';
import '../../../constants/routes.dart';

class LoginScreenBloc extends StatefulWidget {
  const LoginScreenBloc({Key? key}) : super(key: key);

  @override
  State<LoginScreenBloc> createState() => _LoginScreenBlocState();
}

class _LoginScreenBlocState extends State<LoginScreenBloc> {

  final _formKey = GlobalKey<FormState>();
  bool isOffline = false;

  @override
  Widget build(BuildContext context) {

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

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
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(
                          fontFamily: 'NotoSans',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: 'Welcome to ',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
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
                        ]),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Please enter your email below to start using app.',
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
                      icon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'E - Mail',
                      hintStyle: TextStyle(
                        fontFamily: 'NotoSans',
                      )),
                ),
                SizedBox(
                  height: 10,
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
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffF0F0F1),
                    icon: Icon(Icons.password),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      fontFamily: 'NotoSans',
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: (){
                      // Get.toNamed('/ForgotPasswordPageGet');
                      Navigator.of(context).pushNamed(Routes.forgotPasswordPageBloc);
                    },
                    child: Text('Forgot password?',
                      style: TextStyle(
                        color: Color.fromARGB(240, 240, 109, 86),
                      ),
                    ),
                  ),
                ),
                BlocConsumer<LoginCubit, LoginState>(
                    listener: (context, state){
                      if(state is LoginSuccessState){
                        Navigator.of(context).pushNamed(Routes.bottomNavigationBloc);
                      }
                      else if(state is LoginFailedState){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Failed!!')));
                        Navigator.of(context).pushNamedAndRemoveUntil(Routes.loginPageBloc, (route) => false);
                      }
                      else if(state is LoginErrorState){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid username or password!')));
                      }
                    },
                  builder: (context, state){
                      if(state is LoginLoadingState){
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
                          // login(emailController.text, passwordController.text);
                          // context.login(emailController.text, passwordController.text);
                          BlocProvider.of<LoginCubit>(context).login(emailController.text, passwordController.text);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sign in',
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
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(
                        fontFamily: 'NotoSans',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(Routes.registerPageBloc);
                      },
                      child: Text(
                        'Join now',
                        style: TextStyle(
                          color: Color.fromARGB(240, 240, 109, 86),
                          fontFamily: 'NotoSans',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
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
