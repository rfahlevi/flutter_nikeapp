// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter_nikeapp/domain/entities/result.dart';
import 'package:flutter_nikeapp/domain/usecase/get-product-categories/get_product_categories.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_nikeapp/data/repositories/product-category/product_category_repository.dart';

import '../../../../domain/entities/product.dart';

part 'get_product_categories_bloc.freezed.dart';
part 'get_product_categories_event.dart';
part 'get_product_categories_state.dart';

class GetProductCategoriesBloc extends Bloc<GetProductCategoriesEvent, GetProductCategoriesState> {
  final ProductCategoryRepository _productCategoryRepository;
  GetProductCategoriesBloc(
    this._productCategoryRepository,
  ) : super(const _Initial()) {
    on<_DoGet>((event, emit) async {
      emit(const _Loading());

      GetProductCategories getProductCategories = GetProductCategories(
        productCategoryRepository: _productCategoryRepository,
      );

      final result = await getProductCategories(null);

      switch (result) {
        case Success(value: final categories):
          emit(_Success(categories: categories));
          break;
        case Failed(:final message):
          emit(_Failed(message: message));
          break;
      }
    });
  }
}
