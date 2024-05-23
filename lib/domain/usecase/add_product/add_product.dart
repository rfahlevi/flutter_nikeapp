import 'package:flutter_nikeapp/data/repositories/product/product_repository.dart';
import 'package:flutter_nikeapp/domain/entities/result.dart';
import 'package:flutter_nikeapp/domain/usecase/add_product/add_product_params.dart';
import 'package:flutter_nikeapp/domain/usecase/usecase.dart';

class AddProduct implements Usecase<Result<String>, AddProductParams> {
  final ProductRepository _productRepository;

  AddProduct({required ProductRepository productRepository}) : _productRepository = productRepository;

  @override
  Future<Result<String>> call(AddProductParams params) async {
    final result = await _productRepository.addProduct(
      productCategoryId: params.productCategoryId,
      name: params.name,
      slug: params.slug,
      size: params.size,
      color: params.color,
      images: params.images,
      releaseDate: params.releaseDate,
      isAvailable: params.isAvailable,
      price: params.price,
      description: params.description,
    );

    return switch (result) {
      Success(value: final message) => Result.success(message),
      Failed(:final message) => Result.failed(message),
    };
  }
}
