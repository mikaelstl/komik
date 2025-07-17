import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/components/cards/setting_tile.dart';
import 'package:komik/components/texts/base_text.dart';
import 'package:komik/components/texts/language_text.dart';
import 'package:komik/components/texts/option_text.dart';
import 'package:komik/components/texts/toolbar_title.dart';
import 'package:komik/components/tool-bars/settings_toolbar.dart';
import 'package:komik/service/config/user_settings.dart';
import 'package:get/get.dart';
import 'package:komik/service/config/user_settings_controller.dart';

class Settings extends StatelessWidget {
  late UserSettings userSettings = UserSettings.getInstance();

  final settingsController = Get.put(UserSettingsController());

  Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SettingsToolBar(
        title: ToolbarTitle('Configurações')
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 24),
        child: Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _idiom(context),
            _divider(),
            _defaultFolder(context),
          ],
        ),
      )
    );
  }

  Widget _divider() {
    return Divider(
      color: Palette.comic_icon,
      thickness: 2,
      height: 2,
    );
  }

  Widget _idiom(BuildContext context) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SettingTile(
          icon: HeroIcons.language,
          label: 'Linguagem',
          trailing: LanguageText(settingsController.language.value),
          action: () => Navigator.pushNamed(context, '/idioms')
        ),
      )
    );
  }

  Widget _defaultFolder(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          SettingTile(
            icon: HeroIcons.folder,
            label: 'Local dos arquivos',
            trailing: HeroIcon(
              HeroIcons.chevronRight,
              color: Palette.white,
              style: HeroIconStyle.solid,
              size: 26,
            ),
            action: () => Navigator.pushNamed(context, '/local-files'),
          ),
        ],
      ),
    );
  }

  Widget _suboption({
    required String title,
    required String subtitle
  }){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 274,
            child: Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OptionText(title),
                BaseText(
                  subtitle,
                  softWrap: true,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}