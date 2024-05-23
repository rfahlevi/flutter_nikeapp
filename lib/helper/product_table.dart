class ProductTable {
  int? id;
  int productCategoryId;
  String name;
  String slug;
  String size;
  String color;
  String image;
  String releaseDate;
  int isAvailable;
  int price;
  String description;

  ProductTable({
    this.id,
    required this.productCategoryId,
    required this.name,
    required this.slug,
    required this.size,
    required this.color,
    required this.image,
    required this.releaseDate,
    required this.isAvailable,
    required this.price,
    required this.description,
  });

  factory ProductTable.fromJson(Map<String, dynamic> json) {
    return ProductTable(
      id: json['id'],
      productCategoryId: json['product_category_id'],
      name: json['name'],
      slug: json['slug'],
      size: json['size'],
      color: json['color'],
      image: json['image'],
      releaseDate: json['release_date'],
      isAvailable: json['is_available'],
      price: json['price'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_category_id': productCategoryId,
      'name': name,
      'slug': slug,
      'size': size,
      'color': color,
      'image': image,
      'release_date': releaseDate,
      'is_available': isAvailable,
      'price': price,
      'description': description,
    };
  }
}
