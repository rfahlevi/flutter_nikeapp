import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_nikeapp/data/datasources/auth/auth_remote_datasource.dart';
import 'package:flutter_nikeapp/data/datasources/product-category/product_category_remote_datasource.dart';
import 'package:flutter_nikeapp/data/datasources/product/product_remote_datasource.dart';
import 'package:flutter_nikeapp/helper/sqflite_helper.dart';
import 'package:flutter_nikeapp/presentation/blocs/auth/get-user-bloc/get_user_bloc.dart';
import 'package:flutter_nikeapp/presentation/blocs/auth/logout_bloc/logout_bloc.dart';
import 'package:flutter_nikeapp/presentation/blocs/product-category/bloc/get_product_categories_bloc.dart';
import 'package:flutter_nikeapp/presentation/misc/nike_font.dart';
import 'package:flutter_nikeapp/router/router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'helper/const.dart';
import 'presentation/blocs/product/get_products_bloc/get_products_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  EasyLoading.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  initializeDateFormatting();

  if (Platform.isWindows) {
    databaseFactory = databaseFactoryFfi;
  }

  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await SqfliteHelper().init();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetUserBloc(AuthRemoteDatasource())),
        BlocProvider(create: (context) => GetProductsBloc(ProductRemoteDatasource())),
        BlocProvider(create: (context) => GetProductCategoriesBloc(ProductCategoryRemoteDatasource())),
        BlocProvider(create: (context) => LogoutBloc(AuthRemoteDatasource())),
      ],
      child: MaterialApp.router(
        title: 'Nike App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme:
              ColorScheme.fromSeed(seedColor: Colors.black87, onPrimary: Colors.white, primary: Colors.black87),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black87,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              minimumSize: Size(MediaQuery.of(context).size.width, 44),
              textStyle: NikeFont.h4Medium(),
            ),
          ),
        ),
        routerConfig: router,
        builder: EasyLoading.init(),
      ),
    );
  }
}
