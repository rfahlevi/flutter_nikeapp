// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';
import 'dart:io';

import 'package:flutter_nikeapp/domain/entities/product.dart';
import 'package:flutter_nikeapp/helper/product_table.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class SqfliteHelper {
  final String _dbName = 'nikeapp.db';
  final int _dbVersion = 1;
  final String productTable = 'product';
  final String categoryTable = 'category';

  Database? _database;

  Future<Database> init() async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDb();
    return _database!;
  }

  Future initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = p.join(directory.path, _dbName);
    return openDatabase(
      dbPath,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $productTable (id INTEGER PRIMARY KEY, product_category_id INTEGER, name TEXT, slug TEXT, size TEXT, color TEXT, image TEXT, release_date TEXT, is_available INTEGER, price INTEGER, description TEXT, created_at TEXT)',
    );

    await db.execute('CREATE TABLE $categoryTable (id INTEGER PRIMARY KEY, name TEXT, created_at TEXT)');
  }

  // CRUD PRODUCTS
  Future<List<ProductTable>> getProducts({String? search}) async {
    Database db = await init();
    log('$search');
    List<Map<String, dynamic>> result = await db.query(productTable);
    log('$result');
    List<ProductTable> products = result.map((e) => ProductTable.fromJson(e)).toList();
    return products;
  }

  Future<int> addProduct(ProductTable product) async {
    Database db = await init();
    final query = await db.insert(productTable, product.toJson());
    return query;
  }

  Future<int> updateProduct(ProductTable product) async {
    Database db = await init();
    return await db.update(
      productTable,
      product.toJson(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<int> deleteProduct(int id) async {
    Database db = await init();
    final query = await db.delete(productTable, where: 'id = ?', whereArgs: [id]);
    return query;
  }

  Future<int> deleteAllProducts() async {
    Database db = await init();
    final query = await db.delete(productTable);
    return query;
  }

  // CRUD CATEGORIES
  Future<List<Category>> getCategories() async {
    Database db = await init();
    List<Map<String, dynamic>> result = await db.query(categoryTable);

    List<Category> categories = result.map((e) => Category.fromJson(e)).toList();
    return categories;
  }

  Future<int> addCategory(Category category) async {
    Database db = await init();
    final query = await db.insert(categoryTable, category.toJson());
    return query;
  }

  Future<int> deleteCategory(int id) async {
    Database db = await init();
    final query = await db.delete(categoryTable, where: 'id = ?', whereArgs: [id]);
    return query;
  }

  Future<int> deleteAllCategories() async {
    Database db = await init();
    final query = await db.delete(categoryTable);
    return query;
  }
}
