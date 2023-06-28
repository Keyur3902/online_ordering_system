import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:online_ordering_system/GetxProject/ControllerGetx/cartControllerGetx.dart';
import 'package:online_ordering_system/GetxProject/ControllerGetx/orderHistoryControllerGetx.dart';

class OrderHistoryPageGet extends StatefulWidget {
  const OrderHistoryPageGet({Key? key}) : super(key: key);

  @override
  State<OrderHistoryPageGet> createState() => _OrderHistoryPageGetState();
}

class _OrderHistoryPageGetState extends State<OrderHistoryPageGet> {

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
    OrderListControllerGetx orderListControllerGetx =
        Get.put(OrderListControllerGetx());
    CartControllerGetx cartControllerGetx = Get.find();

    return isOffline ? Scaffold(
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
            'My Orders'.tr,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'NotoSans',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Obx(
        () => orderListControllerGetx.isLoadingData.value
            ? Center(
                child: SpinKitSpinningLines(
                  color: Color.fromARGB(240, 240, 109, 86),
                  size: 50.0,
                ),
              )
            : Padding(
                padding:
                    EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 15),
                child: orderListControllerGetx.orderGet.data.isEmpty
                    ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(image: AssetImage('assets/empty-cart.png')),
                      Text(
                        'Your haven\'t ordered anything yet!!'.tr,
                        style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ],
                  ),
                )
                    :ListView.builder(
                  itemCount: orderListControllerGetx.orderGet.data.length,
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
                                image: NetworkImage(orderListControllerGetx
                                    .orderGet.data[index].imageUrl),
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
                                        '#id: '.tr +
                                            orderListControllerGetx
                                                .orderGet.data[index].orderId,
                                        style: TextStyle(
                                          fontFamily: 'NotoSans',
                                          fontWeight: FontWeight.w100,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    // cart.cartProduct.any((element) => element.data[0].productDetails.id) ?
                                    IconButton(
                                      onPressed: () {
                                        String productId = orderListControllerGetx.orderGet.data[index].productId;
                                        cartControllerGetx.addToCart(productId);
                                        Timer(Duration(seconds: 2), () {
                                          Get.offNamed('/CartPageGet');
                                        });
                                      },
                                      icon: Icon(Icons.shopping_cart_outlined),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Ordered on : '.tr +
                                      // orderListControllerGetx
                                      //     .orderGet.data[index].updatedAt
                                      //     .toString(),
                                      DateFormat("dd MMM hh:mm a y").format(orderListControllerGetx
                                            .orderGet.data[index].updatedAt.toLocal()),
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
                                  orderListControllerGetx
                                      .orderGet.data[index].title,
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
                                        '₹ ' +
                                            orderListControllerGetx
                                                .orderGet.data[index].price,
                                        style: TextStyle(
                                          fontFamily: 'NotoSans',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Items: '.tr +
                                          orderListControllerGetx
                                              .orderGet.data[index].quantity
                                              .toString(),
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
                ),
              ),
      ),
    );
  }
}
