import 'package:shared_preferences/shared_preferences.dart';

class UserSettings {
  static late UserSettings _instance;

  late SharedPreferences _sharedPreferences;

  final Map<String, String> _supportedLanguages = {
    'en': 'English',
    'pt': 'Portuguese'
  };

  String get language => _sharedPreferences.getString('language') ?? 'en';

  Future<void> setLanguage(String value) async => await _sharedPreferences.setString('language', value);
  
  String get defaultFolder => _sharedPreferences.getString('default_folder') ?? 'Comics';

  Future<void> setDefaultFolder(String value) async => await _sharedPreferences.setString('default_folder', value);

  static Future<void> initInstance() async {
    _instance = UserSettings();
    _instance._sharedPreferences = await SharedPreferences.getInstance();
    _instance.setDefaultFolder('Comics');
    _instance.setLanguage('en');
  }

  static UserSettings getInstance() => _instance;

  String getLanguageName(String code) {
    return _supportedLanguages[code] ?? 'unknown';
  }
}