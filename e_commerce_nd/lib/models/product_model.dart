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
  bool isFavourite;
  String price;
  String status;
  String description;

  ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.isFavourite,
    required this.price,
    required this.status,
    required this.description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        isFavourite: false,
        price: json["price"],
        status: json["status"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "isFavourite": isFavourite,
        "price": price,
        "status": status,
        "description": description,
      };
}
