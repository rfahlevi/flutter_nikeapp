// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_nikeapp/data/datasources/auth/auth_local_datasource.dart';
import 'package:flutter_nikeapp/data/repositories/product/product_repository.dart';
import 'package:flutter_nikeapp/domain/entities/product.dart';
import 'package:flutter_nikeapp/domain/entities/result.dart';
import 'package:flutter_nikeapp/helper/const.dart';
import 'package:flutter_nikeapp/helper/directory_path.dart';
import 'package:flutter_nikeapp/helper/internet_check.dart';
import 'package:flutter_nikeapp/helper/product_table.dart';
import 'package:flutter_nikeapp/helper/sqflite_helper.dart';
import 'package:path/path.dart' as p;

class ProductRemoteDatasource implements ProductRepository {
  final Dio _dio;

  ProductRemoteDatasource({Dio? dio}) : _dio = dio ?? Dio();

  String baseUrl = NikeConst.baseUrl;

  @override
  Future<Result<String>> addProduct({
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
  }) async {
    try {
      bool hasInternet = await InternetChecker.hasInternetConnection();
      DirectoryPath dirPath = DirectoryPath();
      final folderPath = await dirPath.getPath();

      if (hasInternet) {
        String apiUrl = '$baseUrl/products';
        String? token = await AuthLocalDatasource().getToken();

        slug = '${name.replaceAll(' ', '-').toLowerCase()}-${DateTime.now().millisecondsSinceEpoch}';

        FormData productRequest = FormData.fromMap({
          "product_category_id": productCategoryId,
          "name": name,
          "slug": slug,
          "size": jsonEncode(size),
          "color": jsonEncode(color),
          "release_date": releaseDate,
          "is_available": isAvailable,
          "price": price,
          "description": description,
        });

        for (var image in images) {
          productRequest.files.addAll(
            [
              MapEntry(
                "image[]",
                await MultipartFile.fromFile(
                    isSyncData == true ? '$folderPath/${p.basename(image)}' : File(image).path),
              ),
            ],
          );
        }

        final response = await _dio.post(
          apiUrl,
          data: productRequest,
          options: Options(
            headers: {
              'Content-Type': 'multipart/form-data',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ),
        );

        log('$response');

        final result = response.data;

        if (result['status'] == true) {
          return Result.success(result['message']);
        } else {
          return Result.failed(result['message']);
        }
      } else {
        // Get Device Directory
        DirectoryPath dir = DirectoryPath();

        // Decode image from string to json
        var imageDecode = jsonDecode(jsonEncode(images));
        // Map image to list
        List<String> imageList = List<String>.from(imageDecode);

        for (var i = 0; i < imageList.length; i++) {
          var saveImage = File('${await dir.getPath()}/${DateTime.now().microsecondsSinceEpoch}.jpg');
          var getImage = await saveImage.writeAsBytes(await File(imageList[i]).readAsBytes());

          // Optionally update the image path in the list if you want to keep track of saved images
          imageList.replaceRange(i, i + 1, [jsonDecode(jsonEncode(getImage.path))]);
        }

        await SqfliteHelper().addProduct(
          ProductTable(
            productCategoryId: productCategoryId,
            name: name,
            slug: slug,
            size: jsonEncode(size),
            color: jsonEncode(color),
            image: jsonEncode(imageList),
            releaseDate: releaseDate,
            isAvailable: isAvailable,
            price: price,
            description: description,
          ),
        );
        return const Result.success('You don\'t have internet connection, product added to local database');
      }
    } on DioException catch (e) {
      return Result.failed(e.response?.data['message'] ?? "Something went wrong");
    }
  }

  @override
  Future<Result<List<Product>>> getProducts({
    required String? page,
    required String? productSearch,
  }) async {
    try {
      String apiUrl = '$baseUrl/products?page=$page&product_search=$productSearch';
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
      List<Map<String, dynamic>> productsData = List<Map<String, dynamic>>.from(result['data']);

      if (result['status'] == true) {
        log('$productsData');
        return Result.success(productsData.map((e) => Product.fromJson(e)).toList());
      } else {
        return Result.failed(result['message']);
      }
    } on DioException catch (e) {
      return Result.failed(e.response?.data['message'] ?? "Something went wrong");
    }
  }
}
