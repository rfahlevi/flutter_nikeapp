import 'package:flutter_nikeapp/domain/entities/product.dart';

import '../../../domain/entities/result.dart';

abstract interface class ProductCategoryRepository {
  Future<Result<List<Category>>> getCategories();
}
