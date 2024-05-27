// ignore_for_file: public_member_api_docs, sort_constructors_first
class AddProductParams {
  final int productCategoryId;
  final String name;
  final String slug;
  final List size;
  final List color;
  final List images;
  final String releaseDate;
  final int isAvailable;
  final int price;
  final String description;
  final bool isSyncData;

  AddProductParams({
    required this.productCategoryId,
    required this.name,
    required this.slug,
    required this.size,
    required this.color,
    required this.images,
    required this.releaseDate,
    required this.isAvailable,
    required this.price,
    required this.description,
    required this.isSyncData,
  });
}
