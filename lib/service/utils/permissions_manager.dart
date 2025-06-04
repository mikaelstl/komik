import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsManager {
  late bool haveStorageAccess = false;
  // set _access(bool value) => _access = value;

  PermissionsManager();

  Future<void> request() async {
    debugPrint("ON PERMISSIONS");
  }

  Future<int> androidVersion() async {
    final device = DeviceInfoPlugin();
    final android = await device.androidInfo;

    return int.parse(android.version.release.split('.')[0]);
  }

}