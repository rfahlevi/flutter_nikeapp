import 'package:flutter_nikeapp/data/repositories/product-category/product_category_repository.dart';
import 'package:flutter_nikeapp/domain/entities/product.dart';
import 'package:flutter_nikeapp/domain/entities/result.dart';
import 'package:flutter_nikeapp/domain/usecase/usecase.dart';

class GetProductCategories implements Usecase<Result<List<Category>>, void> {
  final ProductCategoryRepository _productCategoryRepository;

  GetProductCategories({required ProductCategoryRepository productCategoryRepository})
      : _productCategoryRepository = productCategoryRepository;

  @override
  Future<Result<List<Category>>> call(_) async {
    final result = await _productCategoryRepository.getCategories();

    return switch (result) {
      Success(value: final categories) => Result.success(categories),
      Failed(:final message) => Result.failed(message),
    };
  }
}
