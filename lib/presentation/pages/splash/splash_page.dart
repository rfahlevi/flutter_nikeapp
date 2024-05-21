import 'package:flutter/material.dart';
import 'package:flutter_nikeapp/presentation/pages/splash/methods/nike_logo.dart';
import 'package:flutter_nikeapp/presentation/pages/splash/services/splash_service.dart';

class SplashPage extends StatefulWidget {
  static const routerName = '/';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    SplashSercvice.authCheck(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: nikeLogo(context: context),
    );
  }
}
