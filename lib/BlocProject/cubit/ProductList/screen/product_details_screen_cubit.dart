import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:online_ordering_system/BlocProject/cubit/Cart/cubit/cart_cubit.dart';
import 'package:online_ordering_system/BlocProject/cubit/Cart/state/cart_state.dart';
import 'package:online_ordering_system/BlocProject/cubit/Favourites/cubit/favourite_cubit.dart';
import 'package:online_ordering_system/BlocProject/cubit/ProductList/cubit/product_list_cubit.dart';

import '../../Favourites/state/favourite_state.dart';

class ProductDetailsScreenBloc extends StatefulWidget {
  const ProductDetailsScreenBloc({Key? key, this.argument}) : super(key: key);
  final argument;

  @override
  State<ProductDetailsScreenBloc> createState() => _ProductDetailsScreenBlocState();
}

class _ProductDetailsScreenBlocState extends State<ProductDetailsScreenBloc> {
  @override
  Widget build(BuildContext context) {
  final favouriteBlocProvider = BlocProvider.of<FavouriteCubit>(context);
  final cartBlocProvider = BlocProvider.of<CartCubit>(context);
  final productBlocProvider = BlocProvider.of<ProductListCubit>(context);
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            color: Colors.grey,
            iconSize: 15,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          leadingWidth: 75,
          actions: [
            BlocConsumer<FavouriteCubit, FavouriteState>(
              listener: (context, state) {},
                  builder: (context, state) {
                if(state is AddToFavouriteLoadingState){
                  return Center(
                    child: SpinKitSpinningLines(
                      color: Color.fromARGB(240, 240, 109, 86),
                      size: 50.0,
                    ),
                  );
                }
                    return widget.argument.watchListItemId == ''
                        ? IconButton(
              padding: EdgeInsets.only(top: 10, right: 33),
              icon: Icon(Icons.favorite_border_outlined),
              color: Color.fromARGB(240, 240, 109, 86),
              iconSize: 20,
              onPressed: () async {
                    String productId = widget.argument.id;
                    await favouriteBlocProvider.addToFavorite(productId);
                    favouriteBlocProvider.getMyFavorite();
                    productBlocProvider.getData();
              },
            ) : IconButton(
                      padding: EdgeInsets.only(top: 10, right: 33),
                      icon: Icon(Icons.favorite),
                      color: Color.fromARGB(240, 240, 109, 86),
                      iconSize: 20,
                      onPressed: () {},
                    );
                  }
                ),
          ],
        ),
        body: Column(
          children: [
            Flexible(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.40,
                    color: Color(0xffF0F0F1),
                    child: Image.network(widget.argument.imageUrl),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 11,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 26,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '4.9',
                              style: TextStyle(
                                fontFamily: 'NotoSans',
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '(120)',
                              style: TextStyle(
                                fontFamily: 'NotoSans',
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'reviews',
                              style: TextStyle(
                                fontFamily: 'NotoSans',
                                fontSize: 18,
                                color: Color.fromARGB(240, 240, 109, 86),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            widget.argument.title,
                            style: TextStyle(
                              fontFamily: 'NotoSans',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Row(
                          children: [
                            Text(
                              '₹' + widget.argument.price,
                              style: TextStyle(
                                fontFamily: 'NotoSans',
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'VAT included',
                              style: TextStyle(
                                fontFamily: 'NotoSans',
                                fontSize: 20,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Container(height: 1, color: Color(0xffF0F0F1)),
                        SizedBox(
                          height: 6,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Details:',
                            style: TextStyle(
                                fontFamily: 'NotoSans',
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          widget.argument.description,
                          style:
                          TextStyle(fontFamily: 'NotoSans', fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.32,
                    decoration: BoxDecoration(
                        color: Color(0xffF0F0F1),
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 40,
                            width: 40,
                            color: Colors.white,
                            child: GestureDetector(
                              onTap: () {
                                cartBlocProvider.decreaseQuantity(widget.argument.cartItemId);
                              },
                              child: Icon(Icons.remove),
                            ),
                          ),
                        ),
                        Text(
                          widget.argument.quantity.toString(),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 40,
                            width: 40,
                            color: Colors.white,
                            child: GestureDetector(
                              onTap: () {
                                cartBlocProvider.increaseQuantity(widget.argument.cartItemId);
                              },
                              child: Icon(Icons.add),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10,),
                  widget.argument.quantity == 0
                      ? Expanded(
                    child: InkWell(
                      onTap: (){
                        String productId = widget.argument.id;
                        cartBlocProvider.addToCart(productId);
                      },
                      onLongPress: (){},
                      onDoubleTap: (){},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(240, 240, 109, 86),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 18.0, bottom: 18.0),
                            child: Text(
                              'Add to cart',
                              style: TextStyle(
                                  fontFamily: 'NotoSans',
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                      : Flexible(
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // ScaffoldMessenger.of(context)
                          //     .showSnackBar(snackbar);
                        },
                        onLongPress: () {},
                        child: Text(
                          'Added to cart',
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(65, 17, 65, 17),
                          backgroundColor: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
