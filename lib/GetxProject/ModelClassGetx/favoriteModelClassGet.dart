/*
import 'dart:convert';

import 'package:online_ordering_system/GetxProject/ModelClassGetx/productModelClassGet.dart';

FavoriteDataGet favoriteDataFromJson(String str) => FavoriteDataGet.fromJson(json.decode(str));

String favoriteDataToJson(FavoriteDataGet data) => json.encode(data.toJson());

class FavoriteDataGet {
  FavoriteDataGet({
    required this.status,
    required this.msg,
    required this.data,
  });

  int? status;
  String? msg;
  List<FavoriteProductGet>? data;

  factory FavoriteDataGet.fromJson(Map<String, dynamic> json) {
    final List<FavoriteProductGet> dataList = [];
    for (var data in json['data']) {
      dataList.add(FavoriteProductGet.fromJson(data));
    }
    return FavoriteDataGet(
      status: json["status"] ?? 0,
      msg: json["msg"] ?? '',
      data: dataList,
    );
  }

Map<String, dynamic> toJson() => {
  "status": status,
  "msg": msg,
  "data": List<Map<String, dynamic>>.from(data!.map((x) => x.toJson())),
};
}

class FavoriteProductGet {
  FavoriteProductGet({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.productDetailsGet,
  });

  String? id;
  String? userId;
  String? createdAt;
  String? updatedAt;
  int? v;
  DataGet? productDetailsGet;

  factory FavoriteProductGet.fromJson(Map<String, dynamic> json) =>
      FavoriteProductGet(
        id: json["_id"] ?? '',
        userId: json["userId"] ?? '',
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"] ?? 0,
        productDetailsGet: json["productDetailsGet"] != null
            ? DataGet.fromJson(json["productDetailsGet"])
            : DataGet(id: '', title: '', description: '', price: '', imageUrl: ''),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
        "productDetailsGet": productDetailsGet?.toJson(),
      };
}

class ProductDetailsGet {
  ProductDetailsGet({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.v,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  String title;
  String description;
  String price;
  String imageUrl;
  int v;
  DateTime createdAt;
  DateTime updatedAt;

  factory ProductDetailsGet.fromJson(Map<String, dynamic> json) =>
      ProductDetailsGet(
        id: json["_id"] ?? '',
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        price: json["price"] ?? '',
        imageUrl: json["imageUrl"] ?? '',
        v: json["__v"] ?? 0,
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "price": price,
        "imageUrl": imageUrl,
        "__v": v,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
*/



import 'dart:convert';

FavoriteDataGet favoriteDataGetFromJson(String str) => FavoriteDataGet.fromJson(json.decode(str));

String favoriteDataGetToJson(FavoriteDataGet data) => json.encode(data.toJson());

class FavoriteDataGet {
  FavoriteDataGet({
    required this.status,
    required this.msg,
    required this.data,
  });

  int status;
  String msg;
  List<FavoriteProductGet> data;

  factory FavoriteDataGet.fromJson(Map<String, dynamic> json) => FavoriteDataGet(
    status: json["status"],
    msg: json["msg"],
    data: List<FavoriteProductGet>.from(json["data"].map((x) => FavoriteProductGet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class FavoriteProductGet {
  FavoriteProductGet({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.productDetails,
  });

  String id;
  String userId;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  ProductDetailsGet productDetails;

  factory FavoriteProductGet.fromJson(Map<String, dynamic> json) => FavoriteProductGet(
    id: json["_id"],
    userId: json["userId"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    productDetails: ProductDetailsGet.fromJson(json["productDetails"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
    "productDetails": productDetails.toJson(),
  };
}

class ProductDetailsGet {
  ProductDetailsGet({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.v,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  String title;
  String description;
  String price;
  String imageUrl;
  int v;
  DateTime createdAt;
  DateTime updatedAt;

  factory ProductDetailsGet.fromJson(Map<String, dynamic> json) => ProductDetailsGet(
    id: json["_id"],
    title: json["title"],
    description: json["description"],
    price: json["price"],
    imageUrl: json["imageUrl"],
    v: json["__v"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "description": description,
    "price": price,
    "imageUrl": imageUrl,
    "__v": v,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
