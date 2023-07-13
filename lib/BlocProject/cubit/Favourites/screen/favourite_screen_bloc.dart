import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:online_ordering_system/BlocProject/cubit/Cart/state/cart_state.dart';
import 'package:online_ordering_system/BlocProject/cubit/Favourites/cubit/favourite_cubit.dart';
import 'package:online_ordering_system/BlocProject/cubit/Favourites/state/favourite_state.dart';

import '../../../constants/routes.dart';
import '../../Cart/cubit/cart_cubit.dart';

class FavouriteScreenBloc extends StatelessWidget {
  const FavouriteScreenBloc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final favouriteBlocProvider = BlocProvider.of<FavouriteCubit>(context);
    final cartBlocProvider = BlocProvider.of<CartCubit>(context);

    return Scaffold(
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
                // Navigator.pushReplacementNamed(context, '/BottomNavigation');
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
            'Wishlist',
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
        const EdgeInsets.only(top: 30, left: 15, right: 15, bottom: 15),
        child: BlocBuilder<FavouriteCubit, FavouriteState>(
            builder: (context, state) {
              if (state is FavouriteLoadingState) {
                return Center(
                  child: SpinKitSpinningLines(
                    color: Color.fromARGB(240, 240, 109, 86),
                    size: 50.0,
                  ),
                );
              } else if(state is FavouriteErrorState) {
                Navigator.of(context).pushNamed(Routes.loginPageBloc);
                return Text('State: ${state.errorMessage}');
              }
              else if(state is FavouriteEmptyState){
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(image: AssetImage('assets/985675.png')),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Your Favorite Is Empty!!',
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
                      // itemCount: favorite.itemCount,
                      itemCount: favouriteBlocProvider.favoriteProduct[0].data.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xffF0F0F1),
                                  ),
                                  height: 100, //85
                                  width: 100,
                                  child: Image(
                                    image: NetworkImage(favouriteBlocProvider.favoriteProduct[0].data[index].productDetails.imageUrl),
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
                                            favouriteBlocProvider.favoriteProduct[0].data[index].productDetails.title,
                                            style: TextStyle(
                                              fontFamily: 'NotoSans',
                                              fontWeight: FontWeight.w100,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        BlocConsumer<FavouriteCubit, FavouriteState>(
                                            listener: (context, state) {},
                                            builder: (context, state) {
                                              if(state is RemoveFromFavouriteLoadingState && favouriteBlocProvider.isLoadingList[index]){
                                                return Center(
                                                  child: SpinKitSpinningLines(
                                                    color: Color.fromARGB(240, 240, 109, 86),
                                                    size: 50.0,
                                                  ),
                                                );
                                              }
                                              return IconButton(
                                                onPressed: () async {
                                                  String favoriteItemId = favouriteBlocProvider.favoriteProduct[0].data[index].id;
                                                  favouriteBlocProvider.onTapEnableButton(index);
                                                  await favouriteBlocProvider.removeFromFavorite(
                                                      favoriteItemId);
                                                  favouriteBlocProvider.onTapDisableButton(index);
                                                  favouriteBlocProvider.getMyFavorite();
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  size: 20,
                                                ),
                                              );
                                            }
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
                                            '₹ ' +
                                                favouriteBlocProvider.favoriteProduct[0].data[index].productDetails.price,
                                            style: TextStyle(
                                              fontFamily: 'NotoSans',
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        BlocConsumer<CartCubit, CartState>(
                                            listener: (context, state) {},
                                            builder: (context, state) {
                                              if(state is AddToCartLoadingState && favouriteBlocProvider.isLoadingList[index]){
                                                return Center(
                                                  child: SpinKitSpinningLines(
                                                    color: Color.fromARGB(240, 240, 109, 86),
                                                    size: 50.0,
                                                  ),
                                                );
                                              }
                                              return Container(
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color(0xffF0F0F1),
                                                  ),
                                                  child:
                                                  cartBlocProvider.cartProduct.any(
                                                          (element) =>
                                                      element.data[0]
                                                          .quantity ==
                                                          0)
                                                      ? IconButton(
                                                    onPressed: () {
                                                      // ScaffoldMessenger.of(
                                                      //     context)
                                                      //     .showSnackBar(
                                                      //     snackBar);
                                                    },
                                                    icon: Icon(
                                                      Icons.shopping_cart,
                                                      color: Colors.black,
                                                      size: 15,
                                                    ),
                                                  )
                                                      :
                                                  IconButton(
                                                    onPressed: () async {
                                                      String id = favouriteBlocProvider.favoriteProduct[0].data[index].productDetails.id;
                                                      print(id);
                                                      favouriteBlocProvider.onTapEnableButton(index);
                                                      await cartBlocProvider.addToCart(id);
                                                      favouriteBlocProvider.onTapDisableButton(index);
                                                      favouriteBlocProvider.getMyFavorite();
                                                    },
                                                    icon: Icon(
                                                      Icons
                                                          .shopping_cart_outlined,
                                                      color: Colors.black,
                                                      size: 15,
                                                    ),
                                                  ));
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
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
