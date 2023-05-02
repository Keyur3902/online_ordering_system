import 'dart:async';
import 'dart:convert';
import 'package:badges/badges.dart' as Badge;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:online_ordering_system/GetxProject/ControllerGetx/cartControllerGetx.dart';
import 'package:online_ordering_system/GetxProject/ControllerGetx/favoriteControllerGetx.dart';
import 'package:online_ordering_system/GetxProject/ControllerGetx/productControllerGetx.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductListGet extends StatefulWidget {
  const ProductListGet({Key? key}) : super(key: key);

  @override
  State<ProductListGet> createState() => _ProductListGetState();
}

class _ProductListGetState extends State<ProductListGet> {
  //bool isSearch = false;
  List<dynamic> searchedProduct = [];

  StreamSubscription? internetConnection;
  bool isOffline = false;

  late SharedPreferences preferences;

  void initPref() async {
    preferences = await SharedPreferences.getInstance();
  }
  @override
  void initState() {
    // TODO: implement initState
    initPref();
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
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    internetConnection!.cancel();
    super.dispose();
  }

  Future<void> _onSelectedLanguage(String languageCode, String countryCode) async {
    await preferences.setString('language', languageCode);
    await preferences.setString('country', countryCode);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    final ProductListControllerGetx productControllerGet =
        Get.put(ProductListControllerGetx());
    final CartControllerGetx cartControllerGetx = Get.put(CartControllerGetx());
    final FavoriteControllerGetx favoriteControllerGetx =
        Get.put(FavoriteControllerGetx());
    productControllerGet.getData();
    TextEditingController search1 = TextEditingController();

    return SafeArea(
        child: isOffline ? Scaffold(
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
        ) :Scaffold(
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
                    // 'Hello, User!',
                    'hello'.tr,
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'NotoSans',
                    ),
                  ),
                  //CartCounter
                  IconButton(
                    alignment: Alignment.topRight,
                    onPressed: () {
                    },
                    icon: Badge.Badge(
                      badgeStyle: Badge.BadgeStyle(
                        badgeColor: Color.fromARGB(240, 240, 109, 86),
                      ),
                      badgeContent: productControllerGet.isLoading.value
                          ? Text(
                              productControllerGet.welcomeGet.totalProduct
                                  .toString(),
                              style: TextStyle(color: Colors.white),
                            )
                          : Text('0', style: TextStyle(color: Colors.white)),
                      child: Icon(
                        Icons.shopping_cart,
                        size: 30,
                        color: Color(0xff14245B),
                      ),
                    ),
                  ),
                ],
              ),
              // SearchBar
              // GetBuilder<ProductListControllerGetx>(init: ProductListControllerGetx(), builder: (context){
                Row(
                  children: [
                    InkWell(
                      onTap: () => {
                        buildDialog(context),
                      },
                      child: Container(
                        height: Get.height / 22,
                        width: Get.width / 12,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xff14245B)),
                        child: const Icon(
                          Icons.translate_sharp,
                          color: Color.fromARGB(240, 240, 109, 86),
                          size: 25,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    GetBuilder<ProductListControllerGetx>(
                      init: ProductListControllerGetx(),
                      builder: (context) {
                        return Expanded(
                          child: TextField(
                            controller: search1,
                            onChanged: (value) {
                             // search1.text = value;
                              List<dynamic> result = [];
                              if (value.isEmpty) {
                                result = productControllerGet.welcomeGet.data;
                              productControllerGet.isLoadDone1();
                              } else {
                                productControllerGet.isLoadDone();
                                result = productControllerGet.welcomeGet.data
                                    .where((element) => element.title
                                    .toString()
                                    .toLowerCase()
                                    .contains(value.toString().toLowerCase()))
                                    .toList();
                              }
                              searchedProduct = result;
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 12),
                              filled: true,
                              fillColor: Color(0xffF0F0F1),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'Search Products'.tr,
                              hintStyle: TextStyle(
                                fontFamily: 'NotoSans',
                              ),
                              prefixIcon: Icon(Icons.search_rounded),
                            ),
                          ),
                        );
                      }
                    ),
                  ],
                ),
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
                      'Products'.tr,
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
                  Obx(
                    () => productControllerGet.isLoading.value
                        ? Center(
                            child: SpinKitSpinningLines(
                              color: Color.fromARGB(240, 240, 109, 86),
                              size: 50.0,
                            ),
                          )
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * 0.69,
                            child: !productControllerGet.check()
                                ? GridView.builder(
                                    controller: ScrollController(),
                                    itemCount: productControllerGet
                                        .welcomeGet.data.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 13,
                                      crossAxisSpacing: 13,
                                    ),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          Get.toNamed('/ProductDetailsPageGet',
                                              arguments: productControllerGet
                                                  .welcomeGet.data[index]);
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
                                                    alignment:
                                                        Alignment.topRight,
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                          image: NetworkImage(
                                                            productControllerGet
                                                                .welcomeGet
                                                                .data[index]
                                                                .imageUrl,
                                                          ),
                                                        )),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 10),
                                                        child: Container(
                                                          height: 30,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Colors.white,
                                                          ),
                                                          child: productControllerGet
                                                                      .welcomeGet
                                                                      .data[
                                                                          index]
                                                                      .watchListItemId ==
                                                                  ''
                                                              ? IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    String
                                                                        productId =
                                                                        productControllerGet
                                                                            .welcomeGet
                                                                            .data[index]
                                                                            .id;
                                                                    favoriteControllerGetx
                                                                        .addToFavorite(
                                                                            productId);
                                                                    productControllerGet
                                                                        .getData();
                                                                  },
                                                                  icon: Icon(
                                                                    Icons
                                                                        .favorite_border_outlined,
                                                                    color: Colors
                                                                        .black,
                                                                    size: 15,
                                                                  ),
                                                                )
                                                              : IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    String productId = productControllerGet
                                                                        .welcomeGet
                                                                        .data[
                                                                            index]
                                                                        .watchListItemId
                                                                        .toString();
                                                                    favoriteControllerGetx
                                                                        .removeFromFavorite(
                                                                            productId);
                                                                    productControllerGet
                                                                        .getData();
                                                                  },
                                                                  icon: Icon(
                                                                    Icons
                                                                        .favorite,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            240,
                                                                            240,
                                                                            109,
                                                                            86),
                                                                    size: 15,
                                                                  ),
                                                                ),
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
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
                                                          productControllerGet
                                                              .welcomeGet
                                                              .data[index]
                                                              .title,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'NotoSans',
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            '₹ ${productControllerGet
                                                                    .welcomeGet
                                                                    .data[index]
                                                                    .price}',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'NotoSans',
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom:
                                                                        4.0),
                                                            child: Container(
                                                              height: 30,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Color(
                                                                    0xffF0F0F1),
                                                              ),
                                                              child: productControllerGet
                                                                          .welcomeGet
                                                                          .data[
                                                                              index]
                                                                          .quantity ==
                                                                      0
                                                                  ? IconButton(
                                                                      onPressed:
                                                                          () async {
                                                                        String id = productControllerGet
                                                                            .welcomeGet
                                                                            .data[index]
                                                                            .id;
                                                                        print(
                                                                            id);
                                                                        Get.snackbar(
                                                                            'eshop'.tr,
                                                                            'Item will be Added to Cart. Please Wait!!!'.tr,
                                                                            margin: EdgeInsets.only(
                                                                                bottom: 10,
                                                                                left: 10,
                                                                                right: 15));
                                                                        await cartControllerGetx
                                                                            .addToCart(id);
                                                                        productControllerGet
                                                                            .getData();
                                                                      },
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .shopping_cart_outlined,
                                                                        color: Colors
                                                                            .black,
                                                                        size:
                                                                            15,
                                                                      ),
                                                                    ) :
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                    color: Color(0xffF0F0F1),
                                                                    borderRadius: BorderRadius.circular(10)),
                                                                padding: EdgeInsets.all(2),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    ClipRRect(
                                                                      borderRadius: BorderRadius.circular(10),
                                                                      child: Container(
                                                                        height: 30,
                                                                        width: 30,
                                                                        color: Colors.white,
                                                                        child: GestureDetector(
                                                                          onTap: () {
                                                                            // cart.decreaseQuamtity(argument.cartItemId);
                                                                            cartControllerGetx.decreaseQuamtity(productControllerGet.welcomeGet.data[index].cartItemId);
                                                                            productControllerGet.getData();
                                                                          },
                                                                          child: Icon(Icons.remove, size: 10,),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(left: 3, right: 3),
                                                                      child: Text(
                                                                        productControllerGet.welcomeGet.data[index].quantity.toString(),
                                                                      ),
                                                                    ),
                                                                    ClipRRect(
                                                                      borderRadius: BorderRadius.circular(10),
                                                                      child: Container(
                                                                        height: 30,
                                                                        width: 30,
                                                                        color: Colors.white,
                                                                        child: GestureDetector(
                                                                          onTap: () {
                                                                            // cart.increaseQuantity(argument.cartItemId);
                                                                            cartControllerGetx.increaseQuantity(productControllerGet.welcomeGet.data[index].cartItemId);
                                                                            productControllerGet.getData();
                                                                          },
                                                                          child: Icon(Icons.add, size: 10,),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
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
                                  )
                                : GridView.builder(
                                    controller: ScrollController(),
                                    itemCount: searchedProduct.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 13,
                                      crossAxisSpacing: 13,
                                    ),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, '/ProductDetailsPage',
                                              arguments: productControllerGet
                                                  .welcomeGet.data[index]);
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
                                                    alignment:
                                                        Alignment.topRight,
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                          image: NetworkImage(
                                                            searchedProduct[
                                                                    index]
                                                                .imageUrl,
                                                          ),
                                                        )),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 10),
                                                        child: Container(
                                                            height: 30,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            child: productControllerGet
                                                                        .welcomeGet
                                                                        .data[
                                                                            index]
                                                                        .watchListItemId ==
                                                                    ''
                                                                ? IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      String productId = productControllerGet
                                                                          .welcomeGet
                                                                          .data[
                                                                              index]
                                                                          .id;
                                                                      favoriteControllerGetx
                                                                          .addToFavorite(
                                                                              productId);
                                                                    },
                                                                    icon: Icon(
                                                                      Icons
                                                                          .favorite_border_outlined,
                                                                      color: Colors
                                                                          .black,
                                                                      size: 15,
                                                                    ),
                                                                  )
                                                                : IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      String productId = productControllerGet
                                                                          .welcomeGet
                                                                          .data[
                                                                              index]
                                                                          .watchListItemId
                                                                          .toString();
                                                                      favoriteControllerGetx
                                                                          .removeFromFavorite(
                                                                              productId);
                                                                    },
                                                                    icon: Icon(
                                                                      Icons
                                                                          .favorite,
                                                                      color: Color.fromARGB(
                                                                          240,
                                                                          240,
                                                                          109,
                                                                          86),
                                                                      size: 15,
                                                                    ),
                                                                  )),
                                                      ),
                                                    ]),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
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
                                                          searchedProduct[index]
                                                              .title,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'NotoSans',
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            '₹ ' +
                                                                searchedProduct[
                                                                        index]
                                                                    .price,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'NotoSans',
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom:
                                                                        4.0),
                                                            child: Container(
                                                              height: 30,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Color(
                                                                    0xffF0F0F1),
                                                              ),
                                                              child: productControllerGet
                                                                          .welcomeGet
                                                                          .data[
                                                                              index]
                                                                          .quantity ==
                                                                      0
                                                                  ? IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        String id = productControllerGet
                                                                            .welcomeGet
                                                                            .data[index]
                                                                            .id;
                                                                        print(
                                                                            id);
                                                                        cartControllerGetx
                                                                            .addToCart(id);
                                                                      },
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .shopping_cart_outlined,
                                                                        color: Colors
                                                                            .black,
                                                                        size:
                                                                            15,
                                                                      ),
                                                                    )
                                                                  : IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        // ScaffoldMessenger.of(
                                                                        //     context)
                                                                        //     .showSnackBar(
                                                                        //     snackBar);
                                                                      },
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .shopping_cart,
                                                                        color: Colors
                                                                            .black,
                                                                        size:
                                                                            15,
                                                                      ),
                                                                    ),
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
                                  ),
                          ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }

  final List locale = [
    {'name' : 'English', 'locale': Locale('en','US')},
    {'name' : 'Hindi', 'locale': Locale('hi','IN')},
  ];

  updateLanguage(Locale locale){
    Get.back();
    Get.updateLocale(locale);
    // _onSelectedLanguage(languageCode)
  }

  buildDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: const Text('Choose language'),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        updateLanguage(locale[index]['locale']);
                        String localeValue = locale[index]['locale'].toString();
                        List<String> localeParts = localeValue.split('_');
                        String languageCode = localeParts[0];
                        print(languageCode);
                        String countryCode = localeParts[1];
                        _onSelectedLanguage(languageCode, countryCode);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          locale[index]['name'],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: locale.length),
            ),
          );
        });
  }
}
