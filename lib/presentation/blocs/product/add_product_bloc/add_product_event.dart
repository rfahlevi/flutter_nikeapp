part of 'add_product_bloc.dart';

@freezed
class AddProductEvent with _$AddProductEvent {
  const factory AddProductEvent.doAdd({
    required int productCategoryId,
    required String name,
    required String slug,
    required List size,
    required List color,
    required List images,
    required String releaseDate,
    required int isAvailable,
    required int price,
    required String description,
    required bool isSyncData,
  }) = _DoAdd;
}
