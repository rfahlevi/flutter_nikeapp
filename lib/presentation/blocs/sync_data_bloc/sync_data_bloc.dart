// ignore_for_file: public_member_api_docs, sort_constructors_first, depend_on_referenced_packages
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_nikeapp/domain/entities/product.dart';
import 'package:flutter_nikeapp/domain/entities/result.dart';
import 'package:flutter_nikeapp/domain/usecase/add_product/add_product.dart';
import 'package:flutter_nikeapp/domain/usecase/add_product/add_product_params.dart';
import 'package:flutter_nikeapp/domain/usecase/get-product-categories/get_product_categories.dart';
import 'package:flutter_nikeapp/helper/internet_check.dart';
import 'package:flutter_nikeapp/helper/product_table.dart';
import 'package:flutter_nikeapp/helper/sqflite_helper.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart' as path;

import 'package:flutter_nikeapp/data/repositories/product-category/product_category_repository.dart';
import 'package:flutter_nikeapp/data/repositories/product/product_repository.dart';

import '../../../helper/directory_path.dart';

part 'sync_data_bloc.freezed.dart';
part 'sync_data_event.dart';
part 'sync_data_state.dart';

class SyncDataBloc extends Bloc<SyncDataEvent, SyncDataState> {
  final ProductRepository _productRepository;
  final ProductCategoryRepository _productCategoryRepository;
  SyncDataBloc(
    this._productRepository,
    this._productCategoryRepository,
  ) : super(const _Initial()) {
    on<_DoSync>((event, emit) async {
      emit(const _Loading());
      bool hasInternet = await InternetChecker.hasInternetConnection();

      DirectoryPath dirPath = DirectoryPath();
      var folderPath = await dirPath.getPath();
      List imageList = [];

      if (hasInternet) {
        bool productCategoryFinished = false;
        bool productFinished = false;

        List<ProductTable> productsFromLocal = await SqfliteHelper().getProducts();
        List<Category> productCategoriesFromLocal = await SqfliteHelper().getCategories();

        if (productCategoriesFromLocal.isNotEmpty) {
          GetProductCategories getProductCategories = GetProductCategories(
            productCategoryRepository: _productCategoryRepository,
          );

          final result = await getProductCategories(null);

          switch (result) {
            case Success(value: final categories):
              productCategoryFinished = true;
              log('Sync Data productCategoryFinished $productCategoryFinished');
              await SqfliteHelper().deleteAllCategories();
              for (var category in categories) {
                await SqfliteHelper().addCategory(category);
              }
            case Failed(:final message):
              log(message);
          }
        }

        if (productsFromLocal.isNotEmpty) {
          for (var i = 0; i < productsFromLocal.length; i++) {
            AddProduct addProduct = AddProduct(
              productRepository: _productRepository,
            );
            String slug =
                '${productsFromLocal[i].name.replaceAll(' ', '-').toLowerCase()}-${DateTime.now().millisecondsSinceEpoch}';

            var sizeDecode = jsonDecode(productsFromLocal[i].size);
            List sizeList = List.from(sizeDecode);

            var colorDecode = jsonDecode(productsFromLocal[i].color);
            List colorList = List.from(colorDecode);

            var imageDecode = jsonDecode(productsFromLocal[i].image);
            imageList = List.from(imageDecode);

            final result = await addProduct(
              AddProductParams(
                productCategoryId: productsFromLocal[i].productCategoryId,
                name: productsFromLocal[i].name,
                slug: slug,
                size: sizeList,
                color: colorList,
                images: imageList,
                releaseDate: productsFromLocal[i].releaseDate,
                isAvailable: productsFromLocal[i].isAvailable,
                price: productsFromLocal[i].price,
                description: productsFromLocal[i].description,
              ),
            );

            switch (result) {
              case Success(value: _):
                await SqfliteHelper().deleteProduct(productsFromLocal[i].id!);
              case Failed(:final message):
                log(message);
            }

            log('Sync Data productsFromLocal $i');
            if (i == productsFromLocal.length - 1) {
              productFinished = true;
              log('Sync Data productFinished $productFinished');
            }
          }
        }

        if (productFinished == true && productCategoryFinished == true) {
          for (var image in imageList) {
            await File('$folderPath/${path.basename(image)}').delete();
          }
          emit(const _Success(message: 'Sync data success!'));
        } else {
          emit(const _Failed(message: 'Sync data failed!'));
        }
      } else {
        emit(const _Failed(message: 'Please check you internet connections!'));
      }
    });
  }
}
