import 'dart:convert';

WelcomeGet productFromJson(String str) => WelcomeGet.fromJson(json.decode(str));

String productToJson(WelcomeGet data) => json.encode(data.toJson());

class WelcomeGet {
  WelcomeGet({
    required this.status,
    required this.msg,
    required this.totalProduct,
    required this.data,
  });

  int status;
  String msg;
  int totalProduct;
  List<DataGet> data;

  factory WelcomeGet.fromJson(Map<String, dynamic> json) => WelcomeGet(
    status: json["status"] ?? 0,
    msg: json["msg"] ?? '',
    totalProduct: json["totalProduct"] ?? 0,
    data: List<DataGet>.from(json["data"].map((x) => DataGet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "totalProduct": totalProduct,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DataGet {
  DataGet({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.cartItemId,
    this.quantity,
    this.watchListItemId,
  });

  String id;
  String title;
  String description;
  String price;
  String imageUrl;
  String? cartItemId;
  int? quantity;
  String? watchListItemId;

  factory DataGet.fromJson(Map<String, dynamic> json) => DataGet(
    id: json["_id"] ?? '',
    title: json["title"] ?? '',
    description: json["description"] ?? '',
    price: json["price"] ?? '',
    imageUrl: json["imageUrl"] ?? '',
    cartItemId: json["cartItemId"] ?? '',
    quantity: json["quantity"] ?? 0,
    watchListItemId: json["watchListItemId"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "description": description,
    "price": price,
    "imageUrl": imageUrl,
    "cartItemId": cartItemId,
    "quantity": quantity,
    "watchListItemId": watchListItemId,
  };
}
