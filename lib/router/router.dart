import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nikeapp/data/datasources/auth/auth_remote_datasource.dart';
import 'package:flutter_nikeapp/data/datasources/product/product_remote_datasource.dart';
import 'package:flutter_nikeapp/domain/entities/product.dart';
import 'package:flutter_nikeapp/presentation/blocs/auth/login_bloc/login_bloc.dart';
import 'package:flutter_nikeapp/presentation/blocs/product/add_product_bloc/add_product_bloc.dart';
import 'package:flutter_nikeapp/presentation/pages/login/login_page.dart';
import 'package:flutter_nikeapp/presentation/pages/main/main_page.dart';
import 'package:flutter_nikeapp/presentation/pages/product/add-product/add_product_page.dart';
import 'package:flutter_nikeapp/presentation/pages/product/outbox/outbox_page.dart';
import 'package:flutter_nikeapp/presentation/pages/splash/splash_page.dart';
import 'package:go_router/go_router.dart';

import '../presentation/pages/product/detail-product/detail_product_page.dart';

CustomTransitionPage buildPageWithDefaultTransition({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) =>
    CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
        opacity: animation,
        child: child,
      ),
    );

GlobalKey<NavigatorState> routerKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: routerKey,
  routes: [
    GoRoute(
      path: SplashPage.routerName,
      name: SplashPage.routerName,
      builder: (context, state) => const SplashPage(),
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const SplashPage(),
      ),
    ),
    GoRoute(
      path: LoginPage.routerName,
      name: LoginPage.routerName,
      builder: (context, state) => const LoginPage(),
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: BlocProvider(
          create: (context) => LoginBloc(AuthRemoteDatasource()),
          child: const LoginPage(),
        ),
      ),
    ),
    GoRoute(
        path: MainPage.routerName,
        name: MainPage.routerName,
        builder: (context, state) => const MainPage(),
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
              context: context,
              state: state,
              child: const MainPage(),
            ),
        routes: [
          GoRoute(
            path: DetailProductPage.routerName,
            name: DetailProductPage.routerName,
            builder: (context, state) => DetailProductPage(product: state.extra as Product),
            pageBuilder: (context, state) => buildPageWithDefaultTransition(
              context: context,
              state: state,
              child: DetailProductPage(product: state.extra as Product),
            ),
          ),
          GoRoute(
            path: AddProductPage.routerName,
            name: AddProductPage.routerName,
            builder: (context, state) => const AddProductPage(),
            pageBuilder: (context, state) => buildPageWithDefaultTransition(
              context: context,
              state: state,
              child: BlocProvider(
                create: (context) => AddProductBloc(ProductRemoteDatasource()),
                child: const AddProductPage(),
              ),
            ),
          ),
          GoRoute(
            path: OutBoxPage.routerName,
            name: OutBoxPage.routerName,
            builder: (context, state) => const OutBoxPage(),
            pageBuilder: (context, state) => buildPageWithDefaultTransition(
              context: context,
              state: state,
              child: const OutBoxPage(),
            ),
          ),
        ]),
  ],
);
