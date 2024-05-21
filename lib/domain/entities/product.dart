// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'product.g.dart';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

@JsonSerializable()
class Product {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "description")
  String description;
  @JsonKey(name: "category")
  Category category;
  @JsonKey(name: "image")
  List<Image> image;
  @JsonKey(name: "size")
  List<Size> size;
  @JsonKey(name: "color")
  List<Color> color;
  @JsonKey(name: "price")
  String price;
  @JsonKey(name: "release_date")
  DateTime releaseDate;
  @JsonKey(name: "is_available")
  dynamic isAvailable;
  @JsonKey(name: "created_at")
  String createdAt;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.image,
    required this.size,
    required this.color,
    required this.price,
    required this.releaseDate,
    required this.isAvailable,
    required this.createdAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class Category {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "created_at")
  String createdAt;

  Category({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class Color {
  @JsonKey(name: "hex_code")
  String hexCode;
  @JsonKey(name: "name")
  String name;

  Color({
    required this.hexCode,
    required this.name,
  });

  factory Color.fromJson(Map<String, dynamic> json) => _$ColorFromJson(json);

  Map<String, dynamic> toJson() => _$ColorToJson(this);
}

@JsonSerializable()
class Image {
  @JsonKey(name: "image_url")
  String imageUrl;

  Image({
    required this.imageUrl,
  });

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);

  Map<String, dynamic> toJson() => _$ImageToJson(this);
}

@JsonSerializable()
class Size {
  @JsonKey(name: "value")
  String value;

  Size({
    required this.value,
  });

  factory Size.fromJson(Map<String, dynamic> json) => _$SizeFromJson(json);

  Map<String, dynamic> toJson() => _$SizeToJson(this);
}
