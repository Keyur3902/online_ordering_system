import 'package:badges/badges.dart' as Badge;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:online_ordering_system/GetxProject/ControllerGetx/productControllerGetx.dart';

class ProductListGet extends StatefulWidget {
  const ProductListGet({Key? key}) : super(key: key);

  @override
  State<ProductListGet> createState() => _ProductListGetState();
}

class _ProductListGetState extends State<ProductListGet> {
  @override
  Widget build(BuildContext context) {

    final ProductListControllerGetx controller = Get.put(ProductListControllerGetx());

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                //Upper Body  with Notification Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hello, User!',
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'NotoSans',
                      ),
                    ),
                    //CartCounter
                    // IconButton(
                    //   alignment: Alignment.topRight,
                    //   onPressed: () {},
                    //   icon: Badge.Badge(
                    //     badgeStyle: Badge.BadgeStyle(
                    //       badgeColor: Color.fromARGB(240, 240, 109, 86),
                    //     ),
                    //     badgeContent: product.isLoaded ? Text(
                    //       product.data[0].totalProduct.toString(),
                    //       style: TextStyle(color: Colors.white),
                    //     ) : Text('0',style: TextStyle(color: Colors.white)),
                    //     child: Icon(
                    //       Icons.shopping_cart,
                    //       size: 30,
                    //       color: Color(0xff14245B),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                // SearchBar
                //Search bar
                // TextField(
                //   controller: search,
                //   onChanged: (value){
                //     List<dynamic> result = [];
                //     if(value.isEmpty){
                //       result = product.data;
                //       setState(() {
                //         isSearch = false;
                //       });
                //
                //     }else{
                //       result = product.data[0].data.where((element) => element.title.toString().toLowerCase().contains(value.toString().toLowerCase())).toList();
                //       setState(() {
                //         isSearch = true;
                //       });
                //     }
                //     searchedProduct = result;
                //   },
                //   decoration: InputDecoration(
                //     contentPadding: EdgeInsets.symmetric(vertical: 12),
                //     filled: true,
                //     fillColor: Color(0xffF0F0F1),
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(10),
                //       borderSide: BorderSide.none,
                //     ),
                //     hintText: 'Search Products',
                //     hintStyle: TextStyle(
                //       fontFamily: 'NotoSans',
                //     ),
                //     prefixIcon: Icon(Icons.search_rounded),
                //   ),
                // ),
                //SizedBox(height: 20,),
                //Body
                Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Divider(),
                    //Products Text
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Products',
                        style: TextStyle(
                          fontFamily: 'NotoSans',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //Product List View
                    Container(
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: GetBuilder<ProductListControllerGetx>(
                        builder: (context) {
                                if (controller.isLoading.value) {
                                  return
                                    // !isSearch ?
                                    GridView.builder(
                                    controller: ScrollController(),
                                    itemCount: controller.welcomeGet.data.length,
                                    gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 13,
                                      crossAxisSpacing: 13,
                                    ),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          // Navigator.pushNamed(
                                          //     context, '/ProductDetailsPage',
                                          //     arguments:
                                          //     snapshot.data![0].data[index]);
                                        },
                                        child: Card(
                                          elevation: 0,
                                          color: Color(0xffF0F0F1),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              side: BorderSide(
                                                color: Color(0xffF0F0F1),
                                              )),
                                          child: Column(
                                            children: [
                                              Flexible(
                                                child: Stack(
                                                    alignment: Alignment.topRight,
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                              image: NetworkImage(
                                                                controller.welcomeGet.data[index].imageUrl,
                                                              ),
                                                            )),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                        child: Container(
                                                            height: 30,
                                                            decoration:
                                                            BoxDecoration(
                                                              shape:
                                                              BoxShape.circle,
                                                              color: Colors.white,
                                                            ),
                                                            child:
                                                            // snapshot
                                                            //     .data![0]
                                                            //     .data[index]
                                                            //     .watchListItemId ==
                                                            //     ''
                                                            //     ?
                                                            IconButton(
                                                              onPressed: () {
                                                                // String
                                                                // productId =
                                                                //     snapshot
                                                                //         .data![
                                                                //     0]
                                                                //         .data[
                                                                //     index]
                                                                //         .id;
                                                                // favorite.addToFavorite(
                                                                //     productId);
                                                              },
                                                              icon: Icon(
                                                                Icons
                                                                    .favorite_border_outlined,
                                                                color: Colors
                                                                    .black,
                                                                size: 15,
                                                              ),
                                                            )
                                                            //     : IconButton(
                                                            //   onPressed: () {
                                                            //     // String productId = snapshot
                                                            //     //     .data![0]
                                                            //     //     .data[
                                                            //     // index]
                                                            //     //     .watchListItemId
                                                            //     //     .toString();
                                                            //     // favorite.removeFromFavorite(
                                                            //     //     productId);
                                                            //   },
                                                            //   icon: Icon(
                                                            //     Icons
                                                            //         .favorite,
                                                            //     color: Color
                                                            //         .fromARGB(
                                                            //         240,
                                                            //         240,
                                                            //         109,
                                                            //         86),
                                                            //     size: 15,
                                                            //   ),
                                                            // ),
                                                            ),
                                                      ),
                                                    ]),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.only(
                                                      bottomLeft:
                                                      Radius.circular(10),
                                                      bottomRight:
                                                      Radius.circular(10),
                                                    )),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10, right: 10),
                                                  child: Column(
                                                    children: [
                                                      Align(
                                                        alignment:
                                                        Alignment.topLeft,
                                                        child: Text(
                                                          controller.welcomeGet.data[index].title,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              fontFamily:
                                                              'NotoSans',
                                                              color: Colors.black),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Text(
                                                            '₹ ' +
                                                                controller.welcomeGet.data[index].price,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                'NotoSans',
                                                                color: Colors.black,
                                                                fontWeight:
                                                                FontWeight.bold,
                                                                fontSize: 15),
                                                          ),
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .only(
                                                                bottom: 4.0),
                                                            child: Container(
                                                              height: 30,
                                                              decoration:
                                                              BoxDecoration(
                                                                shape:
                                                                BoxShape.circle,
                                                                color: Color(
                                                                    0xffF0F0F1),
                                                              ),
                                                              child:
                                                              // snapshot
                                                              //     .data![0]
                                                              //     .data[
                                                              // index]
                                                              //     .quantity ==
                                                              //     0
                                                              //     ?
                                                              IconButton(
                                                                onPressed:
                                                                    () {
                                                                  // String id = snapshot
                                                                  //     .data![
                                                                  // 0]
                                                                  //     .data[
                                                                  // index]
                                                                  //     .id;
                                                                  // print(id);
                                                                  // cart.addToCart(
                                                                  //     id);
                                                                },
                                                                icon: Icon(
                                                                  Icons
                                                                      .shopping_cart_outlined,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 15,
                                                                ),
                                                              )
                                                              //     : IconButton(
                                                              //   onPressed:
                                                              //       () {
                                                              //     // ScaffoldMessenger.of(
                                                              //     //     context)
                                                              //     //     .showSnackBar(
                                                              //     //     snackBar);
                                                              //   },
                                                              //   icon: Icon(
                                                              //     Icons
                                                              //         .shopping_cart,
                                                              //     color: Colors
                                                              //         .black,
                                                              //     size: 15,
                                                              //   ),
                                                              // ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ) ;
                                  //       :
                                  // GridView.builder(
                                  //   controller: ScrollController(),
                                  //   itemCount: searchedProduct.length,
                                  //   gridDelegate:
                                  //   SliverGridDelegateWithFixedCrossAxisCount(
                                  //     crossAxisCount: 2,
                                  //     mainAxisSpacing: 13,
                                  //     crossAxisSpacing: 13,
                                  //   ),
                                  //   itemBuilder: (context, index) {
                                  //     return InkWell(
                                  //       onTap: () {
                                  //         Navigator.pushNamed(
                                  //             context, '/ProductDetailsPage',
                                  //             arguments:
                                  //             snapshot.data![0].data[index]);
                                  //       },
                                  //       child: Card(
                                  //         elevation: 0,
                                  //         color: Color(0xffF0F0F1),
                                  //         shape: RoundedRectangleBorder(
                                  //             borderRadius:
                                  //             BorderRadius.circular(10),
                                  //             side: BorderSide(
                                  //               color: Color(0xffF0F0F1),
                                  //             )),
                                  //         child: Column(
                                  //           children: [
                                  //             Flexible(
                                  //               child: Stack(
                                  //                   alignment: Alignment.topRight,
                                  //                   children: [
                                  //                     Container(
                                  //                       decoration: BoxDecoration(
                                  //                           image: DecorationImage(
                                  //                             image: NetworkImage(
                                  //                               searchedProduct[index].imageUrl,
                                  //                             ),
                                  //                           )),
                                  //                     ),
                                  //                     Padding(
                                  //                       padding:
                                  //                       const EdgeInsets.only(
                                  //                           top: 10),
                                  //                       child: Container(
                                  //                           height: 30,
                                  //                           decoration:
                                  //                           BoxDecoration(
                                  //                             shape:
                                  //                             BoxShape.circle,
                                  //                             color: Colors.white,
                                  //                           ),
                                  //                           child: snapshot
                                  //                               .data![0]
                                  //                               .data[index]
                                  //                               .watchListItemId ==
                                  //                               ''
                                  //                               ? IconButton(
                                  //                             onPressed: () {
                                  //                               String
                                  //                               productId =
                                  //                                   snapshot
                                  //                                       .data![
                                  //                                   0]
                                  //                                       .data[
                                  //                                   index]
                                  //                                       .id;
                                  //                               favorite.addToFavorite(
                                  //                                   productId);
                                  //                             },
                                  //                             icon: Icon(
                                  //                               Icons
                                  //                                   .favorite_border_outlined,
                                  //                               color: Colors
                                  //                                   .black,
                                  //                               size: 15,
                                  //                             ),
                                  //                           )
                                  //                               : IconButton(
                                  //                             onPressed: () {
                                  //                               String productId = snapshot
                                  //                                   .data![0]
                                  //                                   .data[
                                  //                               index]
                                  //                                   .watchListItemId
                                  //                                   .toString();
                                  //                               favorite.removeFromFavorite(
                                  //                                   productId);
                                  //                             },
                                  //                             icon: Icon(
                                  //                               Icons
                                  //                                   .favorite,
                                  //                               color: Color
                                  //                                   .fromARGB(
                                  //                                   240,
                                  //                                   240,
                                  //                                   109,
                                  //                                   86),
                                  //                               size: 15,
                                  //                             ),
                                  //                           )),
                                  //                     ),
                                  //                   ]),
                                  //             ),
                                  //             Container(
                                  //               decoration: BoxDecoration(
                                  //                   color: Colors.white,
                                  //                   borderRadius: BorderRadius.only(
                                  //                     bottomLeft:
                                  //                     Radius.circular(10),
                                  //                     bottomRight:
                                  //                     Radius.circular(10),
                                  //                   )),
                                  //               child: Padding(
                                  //                 padding: EdgeInsets.only(
                                  //                     left: 10, right: 10),
                                  //                 child: Column(
                                  //                   children: [
                                  //                     Align(
                                  //                       alignment:
                                  //                       Alignment.topLeft,
                                  //                       child: Text(
                                  //                         searchedProduct[index].title,
                                  //                         maxLines: 1,
                                  //                         style: TextStyle(
                                  //                             fontFamily:
                                  //                             'NotoSans',
                                  //                             color: Colors.black),
                                  //                       ),
                                  //                     ),
                                  //                     Row(
                                  //                       mainAxisAlignment:
                                  //                       MainAxisAlignment
                                  //                           .spaceBetween,
                                  //                       children: [
                                  //                         Text(
                                  //                           '₹ ' +
                                  //                               searchedProduct[index].price,
                                  //                           style: TextStyle(
                                  //                               fontFamily:
                                  //                               'NotoSans',
                                  //                               color: Colors.black,
                                  //                               fontWeight:
                                  //                               FontWeight.bold,
                                  //                               fontSize: 15),
                                  //                         ),
                                  //                         Padding(
                                  //                           padding:
                                  //                           const EdgeInsets
                                  //                               .only(
                                  //                               bottom: 4.0),
                                  //                           child: Container(
                                  //                             height: 30,
                                  //                             decoration:
                                  //                             BoxDecoration(
                                  //                               shape:
                                  //                               BoxShape.circle,
                                  //                               color: Color(
                                  //                                   0xffF0F0F1),
                                  //                             ),
                                  //                             child: snapshot
                                  //                                 .data![0]
                                  //                                 .data[
                                  //                             index]
                                  //                                 .quantity ==
                                  //                                 0
                                  //                                 ? IconButton(
                                  //                               onPressed:
                                  //                                   () {
                                  //                                 String id = snapshot
                                  //                                     .data![
                                  //                                 0]
                                  //                                     .data[
                                  //                                 index]
                                  //                                     .id;
                                  //                                 print(id);
                                  //                                 cart.addToCart(
                                  //                                     id);
                                  //                               },
                                  //                               icon: Icon(
                                  //                                 Icons
                                  //                                     .shopping_cart_outlined,
                                  //                                 color: Colors
                                  //                                     .black,
                                  //                                 size: 15,
                                  //                               ),
                                  //                             )
                                  //                                 : IconButton(
                                  //                               onPressed:
                                  //                                   () {
                                  //                                 ScaffoldMessenger.of(
                                  //                                     context)
                                  //                                     .showSnackBar(
                                  //                                     snackBar);
                                  //                               },
                                  //                               icon: Icon(
                                  //                                 Icons
                                  //                                     .shopping_cart,
                                  //                                 color: Colors
                                  //                                     .black,
                                  //                                 size: 15,
                                  //                               ),
                                  //                             ),
                                  //                           ),
                                  //                         ),
                                  //                       ],
                                  //                     )
                                  //                   ],
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     );
                                  //   },
                                  // );
                                } else {
                                  return Center(
                                    child: SpinKitSpinningLines(
                                      color: Color.fromARGB(240, 240, 109, 86),
                                      size: 50.0,
                                    ),
                                  );
                                }
                        }
                      )
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
