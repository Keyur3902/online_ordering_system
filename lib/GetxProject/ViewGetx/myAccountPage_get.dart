import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ordering_system/GetxProject/ControllerGetx/imageControllerGetx.dart';

class MyAccountPageGet extends StatefulWidget {
  const MyAccountPageGet({Key? key}) : super(key: key);

  @override
  State<MyAccountPageGet> createState() => _MyAccountPageGetState();
}

class _MyAccountPageGetState extends State<MyAccountPageGet> {
  Map<String, dynamic> argument = {};
  ImageControllerGetx imageController = Get.put(ImageControllerGetx());
  onPictureSelection() async {
      imageController.getImage();
  }

  @override
  Widget build(BuildContext context) {
    argument =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
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
                Navigator.pop(context);
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
            'Profile'.tr,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'NotoSans',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
        child: Column(
          children: [
            GetBuilder<ImageControllerGetx>(
              init: ImageControllerGetx(),
              builder: (context) {
                return Stack(children: [
                  Container(
                    height: Get.height * 0.15,
                    decoration: BoxDecoration(
                      image: context.imagePath == '' ? DecorationImage(
                        image: AssetImage('assets/145926.png'),
                        fit: BoxFit.contain,
                      ) : DecorationImage(
                        image: FileImage(File(context.imagePath)),
                        fit: BoxFit.contain,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      shape: BoxShape.circle,
                    ),
                  ),
                  Positioned(
                    right: 115,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        shape: BoxShape.circle,
                        color: Color.fromARGB(240, 240, 109, 86),
                      ),
                      height: 35,
                      width: 35,
                      child: IconButton(
                        onPressed: () {
                          onPictureSelection();
                        },
                        icon: Icon(Icons.camera_alt),
                        iconSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ]);
              }
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              argument['args2'].toString(),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'NotoSans',
              ),
            ),
            Text(
              'Member'.tr,
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'NotoSans',
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              children: [
                TextFormField(
                  controller: TextEditingController(),
                  readOnly: true,
                  decoration: InputDecoration(
                      filled: true,
                      prefixIcon: Icon(Icons.person_rounded),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: argument['args2'].toString(),
                      hintStyle: TextStyle(
                        fontFamily: 'NotoSans',
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: TextEditingController(),
                  readOnly: true,
                  decoration: InputDecoration(
                      filled: true,
                      prefixIcon: Icon(Icons.mail),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: argument['args1'].toString(),
                      hintStyle: TextStyle(
                        fontFamily: 'NotoSans',
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  readOnly: true,
                  controller: TextEditingController(),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: argument['args3'].toString(),
                      prefixIcon: Icon(Icons.phone),
                      hintStyle: TextStyle(
                        fontFamily: 'NotoSans',
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
