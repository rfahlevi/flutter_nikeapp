part of 'get_product_categories_bloc.dart';

@freezed
class GetProductCategoriesState with _$GetProductCategoriesState {
  const factory GetProductCategoriesState.initial() = _Initial;
  const factory GetProductCategoriesState.loading() = _Loading;
  const factory GetProductCategoriesState.success({required List<Category> categories}) = _Success;
  const factory GetProductCategoriesState.failed({required String message}) = _Failed;
}
