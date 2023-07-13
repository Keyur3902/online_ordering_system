import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:online_ordering_system/BlocProject/cubit/OrderHistory/cubit/order_history_cubit.dart';
import 'package:online_ordering_system/BlocProject/cubit/OrderHistory/state/order_history_state.dart';

import '../../../constants/routes.dart';

class OrderHistoryScreenBloc extends StatelessWidget {
  const OrderHistoryScreenBloc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
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
                Navigator.pushReplacementNamed(context, Routes.bottomNavigationBloc);
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
            'My Orders',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'NotoSans',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 15),
        child: BlocBuilder<OrderHistoryCubit, OrderHistoryState>(
            builder: (context, state) {
              if(state is OrderHistoryLoadingState){
                return Center(
                  child: SpinKitSpinningLines(
                    color: Color.fromARGB(240, 240, 109, 86),
                    size: 50.0,
                  ),
                );
              }
              else if(state is OrderHistoryLoadedState){
                return ListView.builder(
                    itemCount: state.orderItem[0].data.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xffF6F6F6),
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                height: 100, //85
                                width: 100,
                                child: Image(
                                  image: NetworkImage(state.orderItem[0].data[index].imageUrl),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          '#id: ' + state.orderItem[0].data[index].orderId,
                                          style: TextStyle(
                                            fontFamily: 'NotoSans',
                                            fontWeight: FontWeight.w100,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      // cart.cartProduct.any((element) => element.data[0].productDetails.id) ?
                                      IconButton(
                                        onPressed: (){
                                          // cart.addToCart(state.orderItem[0].data[index].productId);
                                        },
                                        icon: Icon(Icons.shopping_cart_outlined),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Ordered on : ' + state.orderItem[0].data[index].updatedAt.toString(),
                                    style: TextStyle(
                                      fontFamily: 'NotoSans',
                                      fontWeight: FontWeight.w100,
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "${state.orderItem[0].data[index].title}",
                                    style: TextStyle(
                                      fontFamily: 'NotoSans',
                                      fontWeight: FontWeight.w100,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '₹ ' + state.orderItem[0].data[index].price,
                                          style: TextStyle(
                                            fontFamily: 'NotoSans',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Items: ' + state.orderItem[0].data[index].quantity.toString(),
                                        style: TextStyle(
                                          fontFamily: 'NotoSans',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 16,
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
                    ),
                  );
              }
              else if(state is OrderHistoryEmptyState){
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(image: AssetImage('assets/empty-orderHistory.png')),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Your Order History Is Empty!!',
                        style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ],
                  ),
                );
              }
              else if (state is OrderHistoryErrorState){
                return Text(
                  'State: ${state.errorMessage}',
                );
              }
              else{
                return Text('error!');
              }
            }
        ),
      ),
    );
  }
}
