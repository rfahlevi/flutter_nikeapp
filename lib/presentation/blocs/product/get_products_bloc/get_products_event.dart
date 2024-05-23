part of 'get_products_bloc.dart';

@freezed
class GetProductsEvent with _$GetProductsEvent {
  const factory GetProductsEvent.getFirst({
    required String? productSearch,
  }) = _GetFirst;

  const factory GetProductsEvent.getNext({
    required String? productSearch,
  }) = _GetNext;
}
