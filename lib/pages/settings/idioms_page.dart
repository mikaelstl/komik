import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komik/components/cards/idiom_tile.dart';
import 'package:komik/components/texts/option_text.dart';
import 'package:komik/components/tool-bars/settings_toolbar.dart';
import 'package:komik/service/config/user_settings.dart';
import 'package:komik/service/config/user_settings_controller.dart';

class IdiomsPage extends StatelessWidget {
  final UserSettings userSettings = UserSettings.getInstance();
  final settingController = Get.find<UserSettingsController>();

  final List<Locale> idioms;

  IdiomsPage(this.idioms, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SettingsToolBar(
        title: OptionText('Idiomas')
      ),
      body: SingleChildScrollView(
        child: Column(
          children: idioms.map((idiom) => IdiomTile(
            idiom: userSettings.getLanguageName(idiom.languageCode),
            code: idiom.languageCode,
            action: () => settingController.setLanguage(idiom.languageCode).then(
              (_) => Navigator.pop(context)
            ),
          )).toList(),
        ),
      ),
    );
  }
}