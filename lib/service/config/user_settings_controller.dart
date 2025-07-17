import 'package:get/get.dart';
import 'package:komik/service/config/user_settings.dart';

class UserSettingsController extends GetxController {
  final UserSettings userSettings = UserSettings.getInstance();

  late RxString language = userSettings.language.obs;

  late RxString defaultFolder = userSettings.defaultFolder.obs;

  Future<void> setLanguage(String value) async {
    language.value = value;
    await userSettings.setLanguage(value);
  }

  Future<void> setDefaultFolder(String value) async {
    defaultFolder.value = value;
    await userSettings.setDefaultFolder(value);
  }
}