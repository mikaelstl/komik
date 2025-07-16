import 'package:shared_preferences/shared_preferences.dart';

class AppConfig {
  final SharedPreferences _sharedPreferences;

  AppConfig(SharedPreferences shared_preferences) : _sharedPreferences = shared_preferences;

  String get language => _sharedPreferences.getString('language') ?? 'en';

  Future<void> setLanguage(String value) async => await _sharedPreferences.setString('language', value);
  
  String get defaultFolder => _sharedPreferences.getString('default_folder') ?? 'Comics';

  Future<void> setDefaultFolder(String value) async => await _sharedPreferences.setString('default_folder', value);

}