import 'package:badges/badges.dart' as Badge;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:online_ordering_system/BlocProject/cubit/Cart/cubit/cart_cubit.dart';
import 'package:online_ordering_system/BlocProject/cubit/Cart/state/cart_state.dart';
import 'package:online_ordering_system/BlocProject/cubit/Favourites/cubit/favourite_cubit.dart';
import 'package:online_ordering_system/BlocProject/cubit/Favourites/state/favourite_state.dart';
import 'package:online_ordering_system/BlocProject/cubit/ProductList/cubit/product_list_cubit.dart';
import 'package:online_ordering_system/BlocProject/cubit/ProductList/screen/product_details_screen_cubit.dart';
import 'package:online_ordering_system/BlocProject/cubit/ProductList/state/product_list_state.dart';

class ProductListScreenBloc extends StatefulWidget {
  ProductListScreenBloc({Key? key}) : super(key: key);

  @override
  State<ProductListScreenBloc> createState() => _ProductListScreenBlocState();
}

class _ProductListScreenBlocState extends State<ProductListScreenBloc> {
  TextEditingController search = TextEditingController();
  bool isSearch = false;

  @override
  Widget build(BuildContext context) {
    final productBlocProvider = BlocProvider.of<ProductListCubit>(context);
    final cartBlocProvider = BlocProvider.of<CartCubit>(context);
    final favouriteBlocProvider = BlocProvider.of<FavouriteCubit>(context);
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
                    IconButton(
                      alignment: Alignment.topRight,
                      onPressed: () {},
                      icon: Badge.Badge(
                        badgeStyle: Badge.BadgeStyle(
                          badgeColor: Color.fromARGB(240, 240, 109, 86),
                        ),
                        badgeContent:
                            // product.isLoaded ? Text(
                            //   product.data[0].totalProduct.toString(),
                            //   style: TextStyle(color: Colors.white),
                            // ) :
                            Text('0', style: TextStyle(color: Colors.white)),
                        child: Icon(
                          Icons.shopping_cart,
                          size: 30,
                          color: Color(0xff14245B),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                //Search bar
                TextField(
                  controller: search,
                  onChanged: (value) {
                    // List<dynamic> result = [];
                    // if(value.isEmpty){
                    //   result = product.data;
                    //   setState(() {
                    //     isSearch = false;
                    //   });
                    //
                    // }else{
                    //   result = product.data[0].data.where((element) => element.title.toString().toLowerCase().contains(value.toString().toLowerCase())).toList();
                    //   setState(() {
                    //     isSearch = true;
                    //   });
                    // }
                    // searchedProduct = result;
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                    filled: true,
                    fillColor: Color(0xffF0F0F1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Search Products',
                    hintStyle: TextStyle(
                      fontFamily: 'NotoSans',
                    ),
                    prefixIcon: Icon(Icons.search_rounded),
                  ),
                ),
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
                      height: MediaQuery.of(context).size.height * 0.685,
                      child: BlocBuilder<ProductListCubit, ProductListState>(
                          builder: (context, state) {
                        if (state is ProductListLoadingState) {
                          return Center(
                            child: SpinKitSpinningLines(
                              color: Color.fromARGB(240, 240, 109, 86),
                              size: 50.0,
                            ),
                          );
                        }
                        if (state is ProductListLoadedState) {
                          return GridView.builder(
                            controller: ScrollController(),
                            itemCount: state.data[0].data.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 13,
                              crossAxisSpacing: 13,
                            ),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreenBloc(argument: state.data[0].data[index],)));
                                },
                                child: Card(
                                  elevation: 0,
                                  color: Color(0xffF0F0F1),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
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
                                                    state.data[0].data[index]
                                                        .imageUrl,
                                                  ),
                                                )),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10, right: 10),
                                                child: BlocConsumer<FavouriteCubit, FavouriteState>(
                                                  listener: (context, state) {},
                                                  builder: (context, state) {
                                                    if((state is AddToFavouriteLoadingState && productBlocProvider.isLoadingList[index]) || (state is RemoveFromFavouriteLoadingState && productBlocProvider.isLoadingList[index])){
                                                      return SpinKitSpinningLines(
                                                        color: Color
                                                            .fromARGB(
                                                            240,
                                                            240,
                                                            109,
                                                            86),
                                                        size: 50.0,
                                                      );
                                                    }
                                                    return Container(
                                                        height: 30,
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: Colors.white,
                                                        ),
                                                        child: productBlocProvider.data[0]
                                                                        .data[index]
                                                                        .watchListItemId ==
                                                                    ''
                                                                ? InkWell(
                                                                    onTap: () async {
                                                                      String
                                                                      productId =
                                                                          productBlocProvider
                                                                              .data[
                                                                          0]
                                                                              .data[
                                                                          index]
                                                                              .id;
                                                                      productBlocProvider.onTapEnableButton(index);
                                                                      await favouriteBlocProvider.addToFavorite(
                                                                          productId);
                                                                      productBlocProvider.onTapDisableButton(index);
                                                                      productBlocProvider.getData();
                                                                    },
                                                                    onDoubleTap:
                                                                        () {},
                                                                    onLongPress:
                                                                        () {},
                                                                    child: Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                                  .all(
                                                                              8.0),
                                                                      child: Icon(
                                                                        Icons
                                                                            .favorite_border_outlined,
                                                                        color: Colors
                                                                            .black,
                                                                        size: 15,
                                                                      ),
                                                                    ),
                                                                  )
                                                                : InkWell(
                                                                    onTap: () async {
                                                                      String productId = productBlocProvider
                                                                          .data[0]
                                                                          .data[
                                                                      index]
                                                                          .watchListItemId
                                                                          .toString();
                                                                      productBlocProvider.onTapEnableButton(index);
                                                                      await favouriteBlocProvider.removeFromFavorite(productId);
                                                                      productBlocProvider.onTapDisableButton(index);
                                                                      productBlocProvider.getData();
                                                                    },
                                                                    child: Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                                  .all(
                                                                              8.0),
                                                                      child: Icon(
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
                                                                  ));
                                                  }
                                                ),
                                              ),
                                            ]),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            )),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  state.data[0].data[index]
                                                      .title,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontFamily: 'NotoSans',
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
                                                        state.data[0]
                                                            .data[index].price,
                                                    style: TextStyle(
                                                        fontFamily: 'NotoSans',
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 5.0),
                                                    child: Container(
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color:
                                                            Color(0xffF0F0F1),
                                                      ),
                                                      child: state
                                                                  .data[0]
                                                                  .data[index]
                                                                  .quantity ==
                                                              0
                                                          ? BlocConsumer<
                                                                  CartCubit,
                                                                  CartState>(
                                                              listener:
                                                                  (context,
                                                                      state) {
                                                              if (state
                                                                  is AddToCartSuccessState) {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(SnackBar(
                                                                        content:
                                                                            Text('Item Added to cart!')));
                                                              }
                                                            }, builder:
                                                                  (context,
                                                                      state) {
                                                              if (state
                                                                      is AddToCartLoadingState &&
                                                                  productBlocProvider
                                                                          .isLoadingList[
                                                                      index]) {
                                                                return Center(
                                                                  child:
                                                                      SpinKitSpinningLines(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            240,
                                                                            240,
                                                                            109,
                                                                            86),
                                                                    size: 50.0,
                                                                  ),
                                                                );
                                                              }
                                                              return InkWell(
                                                                onDoubleTap:
                                                                    () {},
                                                                onLongPress:
                                                                    () {},
                                                                onTap:
                                                                    () async {
                                                                  productBlocProvider
                                                                      .onTapEnableButton(
                                                                          index);
                                                                  String id =
                                                                      productBlocProvider
                                                                          .data[
                                                                              0]
                                                                          .data[
                                                                              index]
                                                                          .id;
                                                                  await cartBlocProvider
                                                                      .addToCart(
                                                                          id);
                                                                  productBlocProvider
                                                                      .onTapDisableButton(
                                                                          index);
                                                                  productBlocProvider.getData();
                                                                },
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Icon(
                                                                    Icons
                                                                        .shopping_cart_outlined,
                                                                    color: Colors
                                                                        .black,
                                                                    size: 15,
                                                                  ),
                                                                ),
                                                              );
                                                            })
                                                          : BlocConsumer<CartCubit, CartState>(
                                                        listener: (context, state){},
                                                            builder: (context, state) {
                                                          if((state is IncreaseCartQuantityLoadingState && productBlocProvider.isLoadingList[index]) || (state is DecreaseCartQuantityLoadingState && productBlocProvider.isLoadingList[index])){
                                                            return Center(
                                                              child:
                                                              SpinKitSpinningLines(
                                                                color: Color
                                                                    .fromARGB(
                                                                    240,
                                                                    240,
                                                                    109,
                                                                    86),
                                                                size: 50.0,
                                                              ),
                                                            );
                                                          }
                                                              return Container(
                                                                  decoration: BoxDecoration(
                                                                      color: Color(
                                                                          0xffF0F0F1),
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                                  10)),
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(2),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                10),
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              30,
                                                                          width: 30,
                                                                          color: Colors
                                                                              .white,
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () async {
                                                                              productBlocProvider.onTapEnableButton(index);
                                                                              await cartBlocProvider.decreaseQuantity(productBlocProvider.data[0].data[index].cartItemId);
                                                                              productBlocProvider.onTapDisableButton(index);
                                                                              productBlocProvider.getData();
                                                                            },
                                                                            child:
                                                                                Icon(
                                                                              Icons
                                                                                  .remove,
                                                                              size:
                                                                                  10,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                                .only(
                                                                            left: 3,
                                                                            right:
                                                                                3),
                                                                        child: Text(
                                                                          productBlocProvider.data[0].data[index].quantity.toString(),
                                                                        ),
                                                                      ),
                                                                      ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                10),
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              30,
                                                                          width: 30,
                                                                          color: Colors
                                                                              .white,
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () async {
                                                                              productBlocProvider.onTapEnableButton(index);
                                                                              await cartBlocProvider.increaseQuantity(productBlocProvider.data[0].data[index].cartItemId);
                                                                              productBlocProvider.onTapDisableButton(index);
                                                                              productBlocProvider.getData();
                                                                            },
                                                                            child:
                                                                                Icon(
                                                                              Icons
                                                                                  .add,
                                                                              size:
                                                                                  10,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                            }
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
                          );
                        } else {
                          return Text('error!!');
                        }
                      }),
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
