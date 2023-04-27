import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseApiCallingGet extends GetxController {

  Future<void> sendPushNotification(String title, String msg) async {
    final prefs = await SharedPreferences.getInstance();
    String? fcmToken = prefs.getString('fcmToken');
    try {
      final body = {
        "to": fcmToken,
        "notification": {
          "title": title, //our name should be send
          "body": msg,
          "android_channel_id": "OnlineOrderingsystem"
        },
        // "data": {
        //   "some_data": "User ID: ${me.id}",
        // },
      };

      var res = await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
            'key=AAAA2CwyNe8:APA91bFtcrcXMvuygBoA1CDbqyOF1BMBhHQZ9pxiuaUV8_ul7Wz8x5nVFApMSLKCixGEe6emMYBfOCx-ugjLCKSt72sHmbmJ3hn_YYtVF4Bvce9kHAtn5WPnhZcPkeSE3dKhLqL098Ec'
          },
          body: jsonEncode(body));
      log('Response status: ${res.statusCode}');
      log('Response body: ${res.body}');
    } catch (e) {
      log('\nsendPushNotificationE: $e');
    }
  }
}