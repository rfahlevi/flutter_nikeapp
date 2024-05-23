// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DirectoryPath {
  getPath() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/nikeapp-products';
    final folder = Directory(path);

    if (!(await folder.exists())) {
      await folder.create(recursive: true);
    }
    return path;
  }
}
