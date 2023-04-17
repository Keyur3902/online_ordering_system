import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:online_ordering_system/provider/favoriteProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/cartProvider.dart';
import '../provider/cloudMessangingProvider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String total = '0';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final favorite = Provider.of<Favorite>(context);
    final firebase = Provider.of<FirebaseApiCalling>(context);

    return Scaffold(
      // extendBodyBehindAppBar: true,
      backgroundColor: Color(0xffF6F6F6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10),
          child: Container(
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/BottomNavigation');
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 15,
              ),
            ),
          ),
        ),
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
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(top: 10, right: 20),
        //     child: IconButton(
        //       onPressed: (){},
        //       icon: Badge.Badge(
        //           badgeStyle: Badge.BadgeStyle(
        //             badgeColor: Color.fromARGB(240, 240, 109, 86),
        //           ),
        //           badgeContent: Text(
        //             total,
        //             style: TextStyle(color: Colors.white),
        //           ),
        //           child: Icon(
        //             Icons.favorite,
        //             size: 30,
        //             color: Color(0xff14245B),
        //           ),
        //     )
        //   ),
        //   )],
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 15),
        child: FutureBuilder(
            future: cart.getMyCart(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: SpinKitSpinningLines(
                    color: Color.fromARGB(240, 240, 109, 86),
                    size: 50.0,
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                return !snapshot.hasData
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                      )
                    : Column(
                        children: [
                          Flexible(
                            child: ListView.builder(
                                itemCount: snapshot.data![0].data.length,
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
                                                image: NetworkImage(snapshot
                                                    .data![0]
                                                    .data[index]
                                                    .productDetails
                                                    .imageUrl),
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
                                                        snapshot
                                                            .data![0]
                                                            .data[index]
                                                            .productDetails
                                                            .title,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'NotoSans',
                                                          fontWeight:
                                                              FontWeight.w100,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        String cartItemId =
                                                            snapshot.data![0]
                                                                .data[index].id;
                                                        print(cartItemId);
                                                        cart.removeFromCart(
                                                            cartItemId);
                                                      },
                                                      icon: Icon(
                                                        Icons.delete,
                                                        size: 20,
                                                      ),
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
                                                        '₹ ' +
                                                            snapshot
                                                                .data![0]
                                                                .data[index]
                                                                .productDetails
                                                                .price,
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
                                                    Container(
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
                                                                onTap: () {
                                                                  String
                                                                      cartItemId =
                                                                      snapshot
                                                                          .data![
                                                                              0]
                                                                          .data[
                                                                              index]
                                                                          .id;
                                                                  cart.decreaseQuamtity(
                                                                      cartItemId);
                                                                },
                                                                child: Icon(Icons
                                                                    .remove),
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            snapshot
                                                                .data![0]
                                                                .data[index]
                                                                .quantity
                                                                .toString(),
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
                                                                onTap: () {
                                                                  String
                                                                      cartItemId =
                                                                      snapshot
                                                                          .data![
                                                                              0]
                                                                          .data[
                                                                              index]
                                                                          .id;
                                                                  cart.increaseQuantity(
                                                                      cartItemId);
                                                                },
                                                                child: Icon(
                                                                    Icons.add),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
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
                                '₹ ' '${cart.cartProduct[0].cartTotal}',
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
                            children: [
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
                                '₹ ' + '${cart.cartProduct[0].cartTotal}',
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
                          ElevatedButton(
                            onPressed: () async {
                              String cartId =
                                  cart.cartProduct[0].data[0].cartId.toString();
                              String cartTotal =
                                  cart.cartProduct[0].cartTotal.toString();
                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              await cart.placeOrder(cartId, cartTotal);
                              firebase.sendPushNotification('eshop',
                                  'Hey ${pref.getString('name')}, your order is successfuly placed! View your order details here');
                              showAlertDialog(context);
                              Timer(Duration(seconds: 3), () {
                                Navigator.pushReplacementNamed(
                                    context, '/BottomNavigation');
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Checkout',
                                  style: TextStyle(
                                      fontFamily: 'NotoSans', fontSize: 15),
                                )
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(240, 240, 109, 86),
                              padding: EdgeInsets.only(top: 15, bottom: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      );
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            }),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
        backgroundColor: Color(0xFF262a34),
        title: Text(
          "Order Placed🎉",
          style: TextStyle(
            color: Color(0xFF0695b4),
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        content: Text(
          "Your Order Placed Succesfully!!",
          style: TextStyle(
              color: Colors.white70, fontWeight: FontWeight.w600, fontSize: 15),
        ));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
