// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter_nikeapp/domain/entities/result.dart';
import 'package:flutter_nikeapp/domain/usecase/add_product/add_product.dart';
import 'package:flutter_nikeapp/domain/usecase/add_product/add_product_params.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_nikeapp/data/repositories/product/product_repository.dart';

part 'add_product_bloc.freezed.dart';
part 'add_product_event.dart';
part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final ProductRepository _productRepository;
  AddProductBloc(
    this._productRepository,
  ) : super(const _Initial()) {
    on<_DoAdd>((event, emit) async {
      emit(const _Loading());

      AddProduct addProduct = AddProduct(productRepository: _productRepository);

      final result = await addProduct(
        AddProductParams(
          productCategoryId: event.productCategoryId,
          name: event.name,
          slug: event.slug,
          size: event.size,
          color: event.color,
          images: event.images,
          releaseDate: event.releaseDate,
          isAvailable: event.isAvailable,
          price: event.price,
          description: event.description,
        ),
      );

      switch (result) {
        case Success(value: final message):
          emit(_Success(message: message));
          break;
        case Failed(:final message):
          emit(_Failed(message: message));
          break;
      }
    });
  }
}
