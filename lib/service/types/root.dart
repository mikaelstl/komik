import 'dart:io';

import 'package:external_path/external_path.dart';

class Root {
  static late String _path;

  static Directory get directory => Directory(path);
  
  static String get path => _path;

  static Future<void> set() async => _path = await ExternalPath.getExternalStoragePublicDirectory('');
}