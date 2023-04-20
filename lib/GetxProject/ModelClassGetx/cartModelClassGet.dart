import 'dart:convert';

CartDataGet cartDataFromJson(String str) => CartDataGet.fromJson(json.decode(str));

String cartDataToJson(CartDataGet data) => json.encode(data.toJson());

class CartDataGet {
  CartDataGet({
    required this.status,
    required this.msg,
    required this.cartTotal,
    required this.data,
  });

  int status;
  String msg;
  double cartTotal;
  List<CartProductGet> data;

  factory CartDataGet.fromJson(Map<String, dynamic> json) => CartDataGet(
    status: json["status"] ?? 0,
    msg: json["msg"] ?? '',
    cartTotal: json["cartTotal"]?.toDouble() ?? 0.0,
    data: List<CartProductGet>.from(json["data"].map((x) => CartProductGet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "cartTotal": cartTotal,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CartProductGet {
  CartProductGet({
    required this.id,
    required this.userId,
    required this.cartId,
    required this.quantity,
    required this.itemTotal,
    required this.productDetailsGet,
  });

  String id;
  String userId;
  String cartId;
  int quantity;
  double itemTotal;
  ProductDetailsGet productDetailsGet;

  factory CartProductGet.fromJson(Map<String, dynamic> json) => CartProductGet(
    id: json["_id"] ?? '',
    userId: json["userId"] ?? '',
    cartId: json["cartId"] ?? '',
    quantity: json["quantity"] ?? 0,
    itemTotal: json["itemTotal"]?.toDouble() ?? 0.0,
    productDetailsGet: ProductDetailsGet.fromJson(json["productDetails"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "cartId": cartId,
    "quantity": quantity,
    "itemTotal": itemTotal,
    "productDetailsGet": productDetailsGet.toJson(),
  };
}

class ProductDetailsGet {
  ProductDetailsGet({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  String id;
  String title;
  String description;
  String price;
  String imageUrl;

  factory ProductDetailsGet.fromJson(Map<String, dynamic> json) => ProductDetailsGet(
    id: json["_id"] ?? '',
    title: json["title"] ?? '',
    description: json["description"] ?? '',
    price: json["price"] ?? '',
    imageUrl: json["imageUrl"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "description": description,
    "price": price,
    "imageUrl": imageUrl,
  };
}
