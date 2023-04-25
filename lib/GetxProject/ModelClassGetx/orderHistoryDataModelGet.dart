
import 'dart:convert';

OrderGet orderFromJson(String str) => OrderGet.fromJson(json.decode(str));

String orderToJson(OrderGet data) => json.encode(data.toJson());

class OrderGet {
  OrderGet({
    required this.status,
    required this.msg,
    required this.data,
  });

  int status;
  String msg;
  List<OrderItemGet> data;

  factory OrderGet.fromJson(Map<String, dynamic> json) => OrderGet(
    status: json["status"]  ?? 0,
    msg: json["msg"] ?? '',
    data: List<OrderItemGet>.from(json["data"].map((x) => OrderItemGet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg ,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class OrderItemGet {
  OrderItemGet({
    required this.id,
    required this.userId,
    required this.orderId,
    required this.productId,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.quantity,
    required this.productTotalAmount,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  String userId;
  String orderId;
  String productId;
  String title;
  String description;
  String price;
  String imageUrl;
  int quantity;
  String productTotalAmount;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory OrderItemGet.fromJson(Map<String, dynamic> json) => OrderItemGet(
    id: json["_id"] ,
    userId: json["userId"],
    orderId: json["orderId"],
    productId: json["productId"],
    title: json["title"],
    description: json["description"],
    price: json["price"],
    imageUrl: json["imageUrl"],
    quantity: json["quantity"],
    productTotalAmount: json["productTotalAmount"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userIdValues.reverse[userId],
    "orderId": orderId,
    "productId": productId,
    "title": title,
    "description": description,
    "price": price,
    "imageUrl": imageUrl,
    "quantity": quantity,
    "productTotalAmount": productTotalAmount,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}

enum UserId { THE_641_C4889_A11_D46_EC14_BB5_EE8 }

final userIdValues = EnumValues({
  "641c4889a11d46ec14bb5ee8": UserId.THE_641_C4889_A11_D46_EC14_BB5_EE8
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

