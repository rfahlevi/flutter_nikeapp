part of 'add_product_bloc.dart';

@freezed
class AddProductState with _$AddProductState {
  const factory AddProductState.initial() = _Initial;
  const factory AddProductState.loading() = _Loading;
  const factory AddProductState.success({required String message}) = _Success;
  const factory AddProductState.failed({required String message}) = _Failed;
}
