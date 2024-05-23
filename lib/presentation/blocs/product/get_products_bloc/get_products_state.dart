part of 'get_products_bloc.dart';

@freezed
class GetProductsState with _$GetProductsState {
  const factory GetProductsState.initial() = _Initial;
  const factory GetProductsState.loading() = _Loading;
  const factory GetProductsState.success({
    required List<Product> products,
    required bool isNext,
  }) = _Success;
  const factory GetProductsState.failed({required String message}) = _Failed;
}
