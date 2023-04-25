import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../ControllerGetx/cartControllerGetx.dart';

class CartPageGet extends StatefulWidget {
  const CartPageGet({Key? key}) : super(key: key);

  @override
  State<CartPageGet> createState() => _CartPageGetState();
}

class _CartPageGetState extends State<CartPageGet> {

  @override
  Widget build(BuildContext context) {
    CartControllerGetx cartControllerGetx = Get.put(CartControllerGetx());
    cartControllerGetx.getMyCartGet();

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
                Get.offNamed('/BottomNavigationGet');
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
      body: Obx(() => cartControllerGetx.isLoadingGetCart.value ? Center(
        child: SpinKitSpinningLines(
          color: Color.fromARGB(240, 240, 109, 86),
          size: 50.0,
        ),
      ) : Padding(
        padding:
        const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 15),
        child:
        cartControllerGetx.cartDataGet.data!.isEmpty
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
            :
        Column(
          children: [
            Flexible(
              child: ListView.builder(
                  itemCount: cartControllerGetx.cartDataGet.data!.length,
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
                                  image: NetworkImage(cartControllerGetx.cartDataGet.data![index].productDetailsGet!.imageUrl!),
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
                                          cartControllerGetx.cartDataGet.data![index].productDetailsGet!.title!,
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
                                          String? cartItemId = cartControllerGetx.cartDataGet.data![index].id;
                                          print(cartItemId);
                                          cartControllerGetx.removeFromCart(
                                              cartItemId!);
                                          cartControllerGetx.getMyCartGet();
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
                                              cartControllerGetx.cartDataGet.data![index].productDetailsGet!.price!,
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
                                                    cartControllerGetx.cartDataGet.data![index].id.toString();
                                                    cartControllerGetx.decreaseQuamtity(
                                                        cartItemId);
                                                    cartControllerGetx.getMyCartGet();
                                                  },
                                                  child: Icon(Icons
                                                      .remove),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              cartControllerGetx.cartDataGet.data![index].quantity.toString(),
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
                                                        cartControllerGetx.cartDataGet.data![index].id.toString();
                                                    cartControllerGetx.increaseQuantity(
                                                        cartItemId);
                                                    cartControllerGetx.getMyCartGet();
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
                  '₹ ' '${cartControllerGetx.cartDataGet.cartTotal}',
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
                  '₹ ' + '${cartControllerGetx.cartDataGet.cartTotal}',
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
                // String cartId =
                // cart.cartProduct[0].data[0].cartId.toString();
                // String cartTotal =
                // cart.cartProduct[0].cartTotal.toString();
                // SharedPreferences pref =
                // await SharedPreferences.getInstance();
                // await cart.placeOrder(cartId, cartTotal);
                // firebase.sendPushNotification('eshop',
                //     'Hey ${pref.getString('name')}, your order is successfuly placed! View your order details here');
                // showAlertDialog(context);
                // Timer(Duration(seconds: 3), () {
                //   Navigator.pushReplacementNamed(
                //       context, '/BottomNavigation');
                // });
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
        ),
      ),
      )
    );
  }
}