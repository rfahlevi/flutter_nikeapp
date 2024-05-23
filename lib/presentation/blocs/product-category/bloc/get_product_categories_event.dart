part of 'get_product_categories_bloc.dart';

@freezed
class GetProductCategoriesEvent with _$GetProductCategoriesEvent {
  const factory GetProductCategoriesEvent.doGet() = _DoGet;
}
