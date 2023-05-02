import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:online_ordering_system/GetxProject/ControllerGetx/cartControllerGetx.dart';
import 'package:online_ordering_system/GetxProject/ControllerGetx/favoriteControllerGetx.dart';

class FavoritePageGet extends StatefulWidget {
  const FavoritePageGet({Key? key}) : super(key: key);

  @override
  State<FavoritePageGet> createState() => _FavoritePageGetState();
}

class _FavoritePageGetState extends State<FavoritePageGet> {

  StreamSubscription? internetConnection;
  bool isOffline = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    internetConnection = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(result == ConnectivityResult.none){
        setState(() {
          isOffline = true;
        });
      }
      else if(result == ConnectivityResult.mobile){
        setState(() {
          isOffline = false;
        });
      }
      else if(result == ConnectivityResult.wifi){
        setState(() {
          isOffline = false;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    internetConnection!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    FavoriteControllerGetx favoriteControllerGetx =
        Get.find();
    favoriteControllerGetx.getMyFavorite();
    CartControllerGetx cartControllerGetx = Get.find();

    return
      isOffline ? Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/wireless.png'),
              SizedBox(height: 10,),
              Text(
                'Oops!! No Internet Connection'.tr,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NotoSans'
                ),
              ),
            ],
          ),
        ),
      ) : Scaffold(
        extendBodyBehindAppBar: true,
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
              'Wishlist'.tr,
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
          //         onPressed: (){},
          //         icon: Badge.Badge(
          //           badgeStyle: Badge.BadgeStyle(
          //             badgeColor: Color.fromARGB(240, 240, 109, 86),
          //           ),
          //           badgeContent: Text(
          //             cart.cartProduct[0].data.length.toString(),
          //             style: TextStyle(color: Colors.white),
          //           ),
          //           child: Icon(
          //             Icons.shopping_cart,
          //             size: 30,
          //             color: Color(0xff14245B),
          //           ),
          //         )
          //     ),
          //   )],
        ),
        body: Obx(
          () => favoriteControllerGetx.isLoadingGetFav.value
              ? Center(
                  child: SpinKitSpinningLines(
                    color: Color.fromARGB(240, 240, 109, 86),
                    size: 50.0,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(
                      top: 30, left: 15, right: 15, bottom: 15),
                  child: favoriteControllerGetx.favoriteDataGet.data.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(image: AssetImage('assets/985675.png')),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Your Favorite Is Empty!!'.tr,
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
                                itemCount: favoriteControllerGetx
                                    .favoriteDataGet.data.length,
                                itemBuilder: (context, index) => Padding(
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
                                              image: NetworkImage(
                                                  favoriteControllerGetx
                                                      .favoriteDataGet
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
                                                      favoriteControllerGetx
                                                          .favoriteDataGet
                                                          .data[index]
                                                          .productDetails
                                                          .title,
                                                      style: TextStyle(
                                                        fontFamily: 'NotoSans',
                                                        fontWeight:
                                                            FontWeight.w100,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      String favoriteItemId =
                                                          favoriteControllerGetx
                                                              .favoriteDataGet
                                                              .data[index]
                                                              .id;
                                                      favoriteControllerGetx
                                                          .removeFromFavorite(
                                                              favoriteItemId);
                                                      favoriteControllerGetx.getMyFavorite();
                                                      Get.snackbar(
                                                          'eshop'.tr,
                                                          'Item Removed from Favorite'.tr,
                                                          margin: EdgeInsets.only(
                                                              bottom: 10,
                                                              left: 10,
                                                              right: 15));
                                                    },
                                                    icon: Icon(
                                                      Icons.delete,
                                                      size: 20,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      '₹ ${favoriteControllerGetx
                                                              .favoriteDataGet
                                                              .data[index]
                                                              .productDetails
                                                              .price}',
                                                      style: TextStyle(
                                                        fontFamily: 'NotoSans',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color:
                                                            Color(0xffF0F0F1),
                                                      ),
                                                      child:
                                                          // cart.cartProduct.any(
                                                          //         (element) =>
                                                          //     element.data[0]
                                                          //         .quantity ==
                                                          //         0)
                                                          //     ? IconButton(
                                                          //   onPressed: () {
                                                          //     ScaffoldMessenger.of(
                                                          //         context)
                                                          //         .showSnackBar(
                                                          //         snackBar);
                                                          //   },
                                                          //   icon: Icon(
                                                          //     Icons.shopping_cart,
                                                          //     color: Colors.black,
                                                          //     size: 15,
                                                          //   ),
                                                          // )
                                                          //     :
                                                          IconButton(
                                                        onPressed: () {
                                                          String id =
                                                              favoriteControllerGetx
                                                                  .favoriteDataGet
                                                                  .data[index]
                                                                  .productDetails
                                                                  .id;
                                                          print(id);
                                                          cartControllerGetx
                                                              .addToCart(id);
                                                        },
                                                        icon: Icon(
                                                          Icons
                                                              .shopping_cart_outlined,
                                                          color: Colors.black,
                                                          size: 15,
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // ElevatedButton(
                            //   onPressed: () {
                            //     ScaffoldMessenger.of(context).showSnackBar(snackBar1);
                            //     // for (int index = 0; index < favorite.items.length; index++) {
                            //     //   cart.addItem(CartItem(
                            //     //       id: favorite.items[index].id,
                            //     //       name: favorite.items[index].name,
                            //     //       image: favorite.items[index].image,
                            //     //       price: favorite.items[index].price));
                            //     // }
                            //     // favorite.clearFavorite();
                            //   },
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: [
                            //       Icon(
                            //         Icons.shopping_cart_outlined,
                            //         size: 20,
                            //       ),
                            //       SizedBox(
                            //         width: 10,
                            //       ),
                            //       Text(
                            //         'Add to cart',
                            //         style:
                            //             TextStyle(fontFamily: 'NotoSans', fontSize: 15),
                            //       )
                            //     ],
                            //   ),
                            //   style: ElevatedButton.styleFrom(
                            //     backgroundColor: Color.fromARGB(240, 240, 109, 86),
                            //     padding: EdgeInsets.only(top: 15, bottom: 15),
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(10),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                ),
        ));
  }
}
