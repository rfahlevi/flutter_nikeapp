import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nikeapp/data/datasources/auth/auth_remote_datasource.dart';
import 'package:flutter_nikeapp/presentation/blocs/auth/login_bloc/login_bloc.dart';
import 'package:flutter_nikeapp/presentation/blocs/auth/logout_bloc/logout_bloc.dart';
import 'package:flutter_nikeapp/presentation/pages/login/login_page.dart';
import 'package:flutter_nikeapp/presentation/pages/main/main_page.dart';
import 'package:flutter_nikeapp/presentation/pages/splash/splash_page.dart';
import 'package:go_router/go_router.dart';

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
        child: BlocProvider(
          create: (context) => LogoutBloc(AuthRemoteDatasource()),
          child: const MainPage(),
        ),
      ),
    ),
  ],
);
