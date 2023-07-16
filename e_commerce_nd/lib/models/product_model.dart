// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);
// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);
// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  String id;
  String name;
  String image;
  bool isFavorite;
  double price;
  String status;
  String description;
  int? qty;

  ProductModel(
      {required this.id,
      required this.name,
      required this.image,
      required this.isFavorite,
      required this.price,
      required this.status,
      required this.description,
      this.qty});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        isFavorite: false,
        price: double.parse(json["price"].toString()),
        status: json["status"],
        description: json["description"],
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "isFavorite": isFavorite,
        "price": price,
        "status": status,
        "description": description,
        "qty": qty,
      };

  ProductModel copyWith({int? qty}) => ProductModel(
      id: id,
      name: name,
      description: description,
      image: image,
      isFavorite: isFavorite,
      qty: qty ?? this.qty,
      price: price,
      status: status);
}
