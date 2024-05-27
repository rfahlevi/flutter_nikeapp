import 'dart:io';

class NikeConst {
  static String baseUrl = 'https://nikeapp.levistudio.my.id/api';
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
