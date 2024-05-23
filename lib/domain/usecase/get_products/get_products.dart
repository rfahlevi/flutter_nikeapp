import 'package:flutter_nikeapp/data/repositories/product/product_repository.dart';
import 'package:flutter_nikeapp/domain/entities/product.dart';
import 'package:flutter_nikeapp/domain/entities/result.dart';
import 'package:flutter_nikeapp/domain/usecase/get_products/get_products_params.dart';
import 'package:flutter_nikeapp/domain/usecase/usecase.dart';

class GetProducts implements Usecase<Result<List<Product>>, GetProductsParams> {
  final ProductRepository _productRepository;

  GetProducts({required ProductRepository productRepository}) : _productRepository = productRepository;

  @override
  Future<Result<List<Product>>> call(GetProductsParams params) async {
    final result = await _productRepository.getProducts(
      page: params.page,
      productSearch: params.productSearch,
    );

    return switch (result) {
      Success(value: final message) => Result.success(message),
      Failed(:final message) => Result.failed(message)
    };
  }
}
