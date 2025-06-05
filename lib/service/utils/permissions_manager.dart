import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsManager {
  late bool haveStorageAccess = false;
  // set _access(bool value) => _access = value;

  PermissionsManager();

  Future<void> request() async {
    try {
      final version = await androidVersion();

      if (version < 11) {
        final status = await Permission.storage.request();
        haveStorageAccess = status.isGranted;
      } else {
        final status = await Permission.manageExternalStorage.request();
        haveStorageAccess = status.isGranted;
      }
    } catch (err) {
      throw Exception('Erro ao solicitar permissão: $err');
    }
  }

  Future<int> androidVersion() async {
    final device = DeviceInfoPlugin();
    final android = await device.androidInfo;

    return int.parse(android.version.release.split('.')[0]);
  }

}