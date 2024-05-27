import 'package:flutter_nikeapp/domain/entities/product.dart';
import 'package:flutter_nikeapp/domain/entities/result.dart';

abstract interface class ProductRepository {
  Future<Result<List<Product>>> getProducts({
    required String? page,
    required String? productSearch,
  });

  Future<Result<String>> addProduct({
    required int productCategoryId,
    required String name,
    required String slug,
    required List size,
    required List color,
    required List images,
    required String releaseDate,
    required int isAvailable,
    required int price,
    required String description,
    required bool isSyncData,
  });
}
