import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nikeapp/presentation/blocs/auth/logout_bloc/logout_bloc.dart';
import 'package:flutter_nikeapp/presentation/blocs/product/get_products_bloc/get_products_bloc.dart';
import 'package:flutter_nikeapp/presentation/misc/nike_alert.dart';
import 'package:flutter_nikeapp/presentation/pages/login/login_page.dart';
import 'package:flutter_nikeapp/presentation/pages/main/methods/header.dart';
import 'package:flutter_nikeapp/presentation/pages/main/methods/products_grid.dart';
import 'package:flutter_nikeapp/presentation/pages/main/methods/search_products.dart';
import 'package:go_router/go_router.dart';

import '../../../data/datasources/auth/auth_local_datasource.dart';
import '../../blocs/auth/get-user-bloc/get_user_bloc.dart';

class MainPage extends StatefulWidget {
  static const routerName = '/main';
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ScrollController scrollC = ScrollController();
  TextEditingController searchC = TextEditingController();
  String? userName;
  bool isNext = false;

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 0),
      () async {
        final authData = await AuthLocalDatasource().getAuthData();
        setState(() {
          userName = authData?.name;
        });
      },
    );
    context.read<GetProductsBloc>().add(const GetProductsEvent.getFirst(productSearch: ''));
    context.read<GetUserBloc>().add(const GetUserEvent.doGet());

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
                ...header(context: context, userName: userName),
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
