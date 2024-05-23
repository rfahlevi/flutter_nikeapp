import 'package:dio/dio.dart';
import 'package:flutter_nikeapp/data/repositories/product-category/product_category_repository.dart';
import 'package:flutter_nikeapp/domain/entities/product.dart';
import 'package:flutter_nikeapp/domain/entities/result.dart';
import 'package:flutter_nikeapp/helper/const.dart';
import 'package:flutter_nikeapp/helper/sqflite_helper.dart';

import '../../../helper/internet_check.dart';
import '../auth/auth_local_datasource.dart';

class ProductCategoryRemoteDatasource implements ProductCategoryRepository {
  final Dio _dio;

  ProductCategoryRemoteDatasource({Dio? dio}) : _dio = dio ?? Dio();

  String baseUrl = NikeConst.baseUrl;

  @override
  Future<Result<List<Category>>> getCategories() async {
    try {
      bool hasInternet = await InternetChecker.hasInternetConnection();
      List<Category> categories = await SqfliteHelper().getCategories();

      if (hasInternet) {
        String apiUrl = '$baseUrl/product-categories';
        String? token = await AuthLocalDatasource().getToken();

        final response = await _dio.get(
          apiUrl,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ),
        );

        final result = response.data;
        List<Map<String, dynamic>> categoriesMap = List<Map<String, dynamic>>.from(result['data']);

        if (result['status'] == true) {
          if (categories.isEmpty) {
            for (var item in categoriesMap) {
              await SqfliteHelper().addCategory(Category.fromJson(item));
            }
          }
          return Result.success(categoriesMap.map((e) => Category.fromJson(e)).toList());
        } else {
          return Result.failed(result['message']);
        }
      } else {
        return Result.success(categories);
      }
    } on DioException catch (e) {
      return Result.failed(e.response?.data['message'] ?? "Something went wrong");
    }
  }
}
