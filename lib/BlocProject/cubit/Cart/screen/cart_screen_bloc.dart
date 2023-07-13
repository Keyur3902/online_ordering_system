import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:online_ordering_system/BlocProject/cubit/Cart/cubit/cart_cubit.dart';
import 'package:online_ordering_system/BlocProject/cubit/Cart/state/cart_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/routes.dart';

class CartScreenBloc extends StatefulWidget {
  const CartScreenBloc({Key? key}) : super(key: key);

  @override
  State<CartScreenBloc> createState() => _CartScreenBlocState();
}

class _CartScreenBlocState extends State<CartScreenBloc> {
  @override
  Widget build(BuildContext context) {
    final cartBlocProvider = BlocProvider.of<CartCubit>(context);
    return Scaffold(
      // extendBodyBehindAppBar: true,
      backgroundColor: Color(0xffF6F6F6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // leading: Padding(
        //   padding: const EdgeInsets.only(top: 10, left: 10),
        //   child: Container(
        //     height: 30,
        //     decoration: BoxDecoration(
        //       shape: BoxShape.circle,
        //       color: Colors.white,
        //     ),
        //     child: IconButton(
        //       onPressed: () {
        //         // Navigator.pushReplacementNamed(context, '/BottomNavigation');
        //       },
        //       icon: Icon(
        //         Icons.arrow_back_ios_new,
        //         color: Colors.black,
        //         size: 15,
        //       ),
        //     ),
        //   ),
        // ),
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            'My Cart',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'NotoSans',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding:
        const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 15),
        child: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              if (state is CartLoadingState) {
                return Center(
                  child: SpinKitSpinningLines(
                    color: Color.fromARGB(240, 240, 109, 86),
                    size: 50.0,
                  ),
                );
              }

              else if(state is CartErrorState){
                return Text(state.errorMessage);
              }
              else if(state is CartFailedState){
                Navigator.pushNamedAndRemoveUntil(context, Routes.loginPageBloc, (route) => false);
                return Text('Failed');
              }
              else if(state is CartEmptyState){
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Image(image: AssetImage('assets/empty-cart.png')),
                      Text(
                        'Your Cart Is Empty!!',
                        style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ],
                  ),
                );
              }
              return Column(
                children: [
                  Flexible(
                    child: ListView.builder(
                        itemCount: cartBlocProvider.cartProduct[0].data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(10)),
                              padding: EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        color: Color(0xffF0F0F1),
                                      ),
                                      height: 100, //85
                                      width: 100,
                                      child: Image(
                                        image: NetworkImage(cartBlocProvider.cartProduct[0].data[index].productDetails.imageUrl),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                cartBlocProvider.cartProduct[0].data[index].productDetails.title,
                                                style: TextStyle(
                                                  fontFamily:
                                                  'NotoSans',
                                                  fontWeight:
                                                  FontWeight.w100,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                            BlocConsumer<CartCubit, CartState>(
                                                listener: (context, state) {},
                                                builder: (context, state) {
                                                  if(state is RemoveFromCartLoadingState && cartBlocProvider.isLoadingList[index]) {
                                                    return Center(
                                                      child: SpinKitSpinningLines(
                                                        color: Color.fromARGB(240, 240, 109, 86),
                                                        size: 50.0,
                                                      ),
                                                    );
                                                  }
                                                  return IconButton(
                                                    onPressed: () async {
                                                      String cartItemId =
                                                          cartBlocProvider.cartProduct[0].data[index].id;
                                                      cartBlocProvider.onTapEnableButton(index);
                                                      await cartBlocProvider.removeFromCart(
                                                          cartItemId);
                                                      cartBlocProvider.onTapDisableButton(index);
                                                      cartBlocProvider.getMyCart();
                                                    },
                                                    icon: Icon(
                                                      Icons.delete,
                                                      size: 20,
                                                    ),
                                                  );
                                                }
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                '₹ ${cartBlocProvider.cartProduct[0].data[index].productDetails.price}',
                                                style: TextStyle(
                                                  fontFamily:
                                                  'NotoSans',
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            BlocConsumer<CartCubit, CartState>(
                                                listener: (context, state) {},
                                                builder: (context, state) {
                                                  if((state is IncreaseCartQuantityLoadingState && cartBlocProvider.isLoadingList[index]) || (state is DecreaseCartQuantityLoadingState && cartBlocProvider.isLoadingList[index])){
                                                    return Center(
                                                      child: SpinKitSpinningLines(
                                                        color: Color.fromARGB(240, 240, 109, 86),
                                                        size: 50.0,
                                                      ),
                                                    );
                                                  }
                                                  return SizedBox(
                                                    width:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.20,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              10),
                                                          child: Container(
                                                            height: 25,
                                                            width: 25,
                                                            color: Color(
                                                                0xffF0F0F1),
                                                            child:
                                                            GestureDetector(
                                                              onTap: () async {
                                                                String
                                                                cartItemId =
                                                                    cartBlocProvider.cartProduct[0].data[index].id;
                                                                cartBlocProvider.onTapEnableButton(index);
                                                                await cartBlocProvider.decreaseQuantity(
                                                                    cartItemId);
                                                                cartBlocProvider.onTapDisableButton(index);
                                                                cartBlocProvider.getMyCart();
                                                              },
                                                              child: Icon(Icons
                                                                  .remove),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          cartBlocProvider.cartProduct[0].data[index].quantity.toString(),
                                                        ),
                                                        ClipRRect(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              10),
                                                          child: Container(
                                                            height: 25,
                                                            width: 25,
                                                            color: Color(
                                                                0xffF0F0F1),
                                                            child:
                                                            GestureDetector(
                                                              onTap: () async {
                                                                String
                                                                cartItemId =
                                                                    cartBlocProvider.cartProduct[0].data[index].id;
                                                                cartBlocProvider.onTapEnableButton(index);
                                                                await cartBlocProvider.increaseQuantity(
                                                                    cartItemId);
                                                                cartBlocProvider.onTapDisableButton(index);
                                                                cartBlocProvider.getMyCart();
                                                              },
                                                              child: Icon(
                                                                  Icons.add),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sub-total',
                        style: TextStyle(
                            color: Colors.grey, fontFamily: 'NotoSans'),
                      ),
                      Text(
                        '₹ ' '${cartBlocProvider.cartProduct[0].cartTotal}',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'NotoSans',
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'VAT (%)',
                        style: TextStyle(
                            color: Colors.grey, fontFamily: 'NotoSans'),
                      ),
                      Text(
                        '₹0,00',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'NotoSans',
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'NotoSans',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '₹ ' '${cartBlocProvider.cartProduct[0].cartTotal}',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'NotoSans',
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  BlocConsumer<CartCubit, CartState>(
                    listener: (context, state) {
                      // if(state is OrderPlacedSuccessState){
                      //   // cartBlocProvider.showAlertDialog(context);
                      // }
                    },
                    builder: (context, state) {
                      if(state is OrderPlaceLoadingState){
                        return Center(
                          child: SpinKitSpinningLines(
                            color: Color.fromARGB(240, 240, 109, 86),
                            size: 50.0,
                          ),
                        );
                      }
                      return ElevatedButton(
                        onPressed: () async {
                          String cartId =
                          cartBlocProvider.cartProduct[0].data[0].cartId.toString();
                          String cartTotal =
                          cartBlocProvider.cartProduct[0].cartTotal.toString();
                          SharedPreferences pref =
                          await SharedPreferences.getInstance();
                          await cartBlocProvider.placeOrder(cartId, cartTotal);
                          // firebase.sendPushNotification('eshop',
                          //     'Hey ${pref.getString('name')}, your order is successfuly placed! View your order details here');
                          cartBlocProvider.showAlertDialog(context);
                          Timer(Duration(seconds: 3), () {
                            Navigator.pushReplacementNamed(
                                context, Routes.bottomNavigationBloc);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          Color.fromARGB(240, 240, 109, 86),
                          padding: EdgeInsets.only(top: 15, bottom: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Checkout',
                              style: TextStyle(
                                  fontFamily: 'NotoSans', fontSize: 15),
                            )
                          ],
                        ),
                      );
                    }
                  ),
                ],
              );
            }),
      ),
    );
  }
}
