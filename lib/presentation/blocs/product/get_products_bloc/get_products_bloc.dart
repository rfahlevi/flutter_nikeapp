// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter_nikeapp/domain/entities/result.dart';
import 'package:flutter_nikeapp/domain/usecase/get_products/get_products.dart';
import 'package:flutter_nikeapp/domain/usecase/get_products/get_products_params.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_nikeapp/data/repositories/product/product_repository.dart';

import '../../../../domain/entities/product.dart';

part 'get_products_bloc.freezed.dart';
part 'get_products_event.dart';
part 'get_products_state.dart';

class GetProductsBloc extends Bloc<GetProductsEvent, GetProductsState> {
  final ProductRepository _productRepository;
  int currentPage = 1;
  bool isNext = false;
  GetProductsBloc(
    this._productRepository,
  ) : super(const _Initial()) {
    on<_GetFirst>((event, emit) async {
      emit(const _Loading());
      currentPage = 1;

      GetProducts getProducts = GetProducts(productRepository: _productRepository);

      final result = await getProducts(GetProductsParams(
        page: currentPage.toString(),
        productSearch: event.productSearch,
      ));

      switch (result) {
        case Success(value: final products):
          isNext = products.length == 20;
          currentPage = currentPage + 1;
          emit(_Success(products: products, isNext: isNext));
          break;
        case Failed(:final message):
          emit(_Failed(message: message));
          break;
      }
    });

    on<_GetNext>((event, emit) async {
      List<Product> currentValue =
          state.whenOrNull(success: (products, isNext) => products)?.map((e) => e).toList() ?? [];

      GetProducts getProducts = GetProducts(productRepository: _productRepository);

      final result = await getProducts(GetProductsParams(
        page: currentPage.toString(),
        productSearch: event.productSearch,
      ));

      switch (result) {
        case Success(value: final products):
          isNext = products.length == 20;
          currentPage = currentPage + 1;
          emit(_Success(products: [...currentValue, ...products], isNext: isNext));
          break;
        case Failed(:final message):
          emit(_Failed(message: message));
          break;
      }
    });
  }
}
