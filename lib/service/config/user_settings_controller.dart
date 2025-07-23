import 'package:flutter/material.dart';
import 'package:komik/service/config/user_settings.dart';

class UserSettingsController extends ChangeNotifier {
  final UserSettings userSettings = UserSettings.getInstance();

  late String language = userSettings.language;

  late String defaultFolder = userSettings.defaultFolder;

  late int comicsAmount = userSettings.comicsAmount;

  Future<void> setLanguage(String value) async {
    language = value;
    await userSettings.setLanguage(value);
  }

  Future<void> setDefaultFolder(String value) async {
    defaultFolder = value;
    await userSettings.setDefaultFolder(value);
  }
}