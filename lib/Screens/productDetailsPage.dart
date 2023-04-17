import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_ordering_system/provider/cartProvider.dart';
import 'package:online_ordering_system/provider/favoriteProvider.dart';
import 'package:provider/provider.dart';
import '../Data/data.dart';

class ProductDetailsPage extends StatefulWidget {
  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  late Data argument;

  SnackBar snackbar = SnackBar(content: Text('Item already added'));

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final favorite = Provider.of<Favorite>(context);
    argument = ModalRoute.of(context)!.settings.arguments as Data;
    print(argument);
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
            argument.watchListItemId == '' ? IconButton(
              padding: EdgeInsets.only(top: 10, right: 33),
              icon: Icon(Icons.favorite_border_outlined),
              color: Color.fromARGB(240, 240, 109, 86),
              iconSize: 20,
              onPressed: () {
                String productId = argument.id;
                favorite.addToFavorite(productId);
              },
            ) : IconButton(
              padding: EdgeInsets.only(top: 10, right: 33),
              icon: Icon(Icons.favorite),
              color: Color.fromARGB(240, 240, 109, 86),
              iconSize: 20,
              onPressed: () {},
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
                    child: Image.network(argument.imageUrl),
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
                            argument.title,
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
                              '₹' + argument.price,
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
                          argument.description,
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
                                cart.decreaseQuamtity(argument.cartItemId);
                              },
                              child: Icon(Icons.remove),
                            ),
                          ),
                        ),
                        Text(
                          argument.quantity.toString(),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 40,
                            width: 40,
                            color: Colors.white,
                            child: GestureDetector(
                              onTap: () {
                                cart.increaseQuantity(argument.cartItemId);
                              },
                              child: Icon(Icons.add),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  argument.quantity == 0 ? Center(
                    child: ElevatedButton(
                      onPressed: () {
                        String productId = argument.id;
                        cart.addToCart(productId);
                      },
                      child: Text(
                        'Add to cart',
                        style: TextStyle(
                          fontFamily: 'NotoSans',
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(75, 17, 75, 17),
                        backgroundColor: Color.fromARGB(240, 240, 109, 86),
                      ),
                    ),
                  ) :
                  Flexible(
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        },
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
