import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_nikeapp/helper/sqflite_helper.dart';
import 'package:flutter_nikeapp/presentation/blocs/auth/logout_bloc/logout_bloc.dart';
import 'package:flutter_nikeapp/presentation/blocs/product/get_products_bloc/get_products_bloc.dart';
import 'package:flutter_nikeapp/presentation/blocs/sync_data_bloc/sync_data_bloc.dart';
import 'package:flutter_nikeapp/presentation/misc/nike_alert.dart';
import 'package:flutter_nikeapp/presentation/pages/login/login_page.dart';
import 'package:flutter_nikeapp/presentation/pages/main/methods/header.dart';
import 'package:flutter_nikeapp/presentation/pages/main/methods/products_grid.dart';
import 'package:flutter_nikeapp/presentation/pages/main/methods/search_products.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../../../helper/product_table.dart';
import '../../blocs/auth/get-user-bloc/get_user_bloc.dart';

class MainPage extends StatefulWidget {
  static const routerName = '/main';
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController searchC = TextEditingController();
  ScrollController scrollC = ScrollController();
  bool isNext = false;

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  List<ProductTable> productsFromLocal = [];
  StreamSubscription? internetListener;

  @override
  void initState() {
    context.read<GetUserBloc>().add(const GetUserEvent.doGet());

    internetListener = InternetConnection().onStatusChange.listen((event) async {
      if (event == InternetStatus.connected) {
        productsFromLocal = await SqfliteHelper().getProducts();
        if (productsFromLocal.isNotEmpty && mounted) {
          context.read<SyncDataBloc>().add(const SyncDataEvent.doSync());
        } else if (mounted) {
          context.read<GetProductsBloc>().add(const GetProductsEvent.getFirst(productSearch: ''));
        }
      }
    });

    scrollC.addListener(() {
      if (scrollC.position.maxScrollExtent == scrollC.offset) {
        isNext = context.read<GetProductsBloc>().isNext;
        if (isNext) {
          context.read<GetProductsBloc>().add(GetProductsEvent.getNext(productSearch: searchC.text));
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    searchC.dispose();
    scrollC.dispose();
    internetListener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LogoutBloc, LogoutState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              success: (hasLogout) {
                if (hasLogout) {
                  NikeAlert.successful(context: context, content: 'Logout Successfully!');
                  context.goNamed(LoginPage.routerName);
                } else {
                  context.goNamed(LoginPage.routerName);
                  NikeAlert.error(context: context, content: 'Logout Failed!');
                }
              },
              failed: (message) {
                NikeAlert.error(context: context, content: message);
              },
            );
          },
        ),
        BlocListener<GetUserBloc, GetUserState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              failed: (message) {
                NikeAlert.error(context: context, content: message);
                context.goNamed(LoginPage.routerName);
              },
            );
          },
        ),
        BlocListener<SyncDataBloc, SyncDataState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              loading: () => EasyLoading.show(status: 'Syncing data on progress..'),
              failed: (message) => EasyLoading.showError(message),
              success: (message) {
                EasyLoading.showSuccess(message);
                context.read<GetProductsBloc>().add(const GetProductsEvent.getFirst(productSearch: ''));
              },
            );
          },
        ),
      ],
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: RefreshIndicator(
            key: refreshIndicatorKey,
            backgroundColor: Colors.white,
            color: Colors.black87,
            strokeWidth: 3,
            onRefresh: () async {
              await Future.delayed(
                const Duration(seconds: 0),
                () {
                  context.read<GetProductsBloc>().add(const GetProductsEvent.getFirst(productSearch: ''));
                },
              );
            },
            child: ListView(
              controller: scrollC,
              children: [
                ...header(context: context),
                ...searchProducts(context: context, searchC: searchC),
                ...productsGrid(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
