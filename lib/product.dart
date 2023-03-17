import 'dart:convert';

class Product {
  final String imgPath;
  final String trackingId;
  final String productName;
  final String address;
  final String status;

  Product({required this.imgPath, required this.trackingId, required this.productName, required this.address, required this.status});

  Map<String, dynamic> toMap() {
    return {
      'path': imgPath,
      'id' : trackingId,
      'productName': productName,
      'address': address,
      'status': status,

    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      imgPath: map['path'] ?? '',
      trackingId: map['_id'] ?? '',
      productName: map['name'] ?? '',
      address: map['address'] ?? '',
      status: map['status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source));
}


