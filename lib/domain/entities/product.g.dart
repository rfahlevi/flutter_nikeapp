// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
      image: (json['image'] as List<dynamic>)
          .map((e) => Image.fromJson(e as Map<String, dynamic>))
          .toList(),
      size: (json['size'] as List<dynamic>)
          .map((e) => Size.fromJson(e as Map<String, dynamic>))
          .toList(),
      color: (json['color'] as List<dynamic>)
          .map((e) => Color.fromJson(e as Map<String, dynamic>))
          .toList(),
      price: (json['price'] as num).toInt(),
      releaseDate: DateTime.parse(json['release_date'] as String),
      isAvailable: json['is_available'],
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'image': instance.image,
      'size': instance.size,
      'color': instance.color,
      'price': instance.price,
      'release_date': instance.releaseDate.toIso8601String(),
      'is_available': instance.isAvailable,
      'created_at': instance.createdAt,
    };

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'created_at': instance.createdAt,
    };

Color _$ColorFromJson(Map<String, dynamic> json) => Color(
      hexCode: json['hex_code'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$ColorToJson(Color instance) => <String, dynamic>{
      'hex_code': instance.hexCode,
      'name': instance.name,
    };

Image _$ImageFromJson(Map<String, dynamic> json) => Image(
      imageUrl: json['image_url'] as String,
    );

Map<String, dynamic> _$ImageToJson(Image instance) => <String, dynamic>{
      'image_url': instance.imageUrl,
    };

Size _$SizeFromJson(Map<String, dynamic> json) => Size(
      value: json['value'] as String,
    );

Map<String, dynamic> _$SizeToJson(Size instance) => <String, dynamic>{
      'value': instance.value,
    };
