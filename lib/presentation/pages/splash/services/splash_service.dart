import 'package:flutter/material.dart';
import 'package:flutter_nikeapp/data/datasources/auth/auth_local_datasource.dart';
import 'package:flutter_nikeapp/presentation/pages/main/main_page.dart';
import 'package:go_router/go_router.dart';

import '../../login/login_page.dart';

class SplashSercvice {
  static void authCheck(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 3),
      () async {
        String? token = await AuthLocalDatasource().getToken();
        print(token);
        if (context.mounted) {
          if (token == null) {
            context.goNamed(LoginPage.routerName);
          } else {
            context.goNamed(MainPage.routerName);
          }
        }
      },
    );
  }
}
