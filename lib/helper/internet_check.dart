import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetChecker {
  static Future<bool> hasInternetConnection() async {
    // CONNECT TO INTERNET?
    if (await InternetConnection().hasInternetAccess) {
      return true;
    } else {
      return false;
    }
  }
}
