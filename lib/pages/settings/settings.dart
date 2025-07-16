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

class Settings extends StatelessWidget {
  const Settings({super.key});

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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SettingTile(
                icon: HeroIcons.language,
                label: 'Linguagem',
                trailing: LanguageText('Pt-BR'),
                action: () {
                  debugPrint('Open language selector modal');
                },
              ),
            ),
            _divider(),
            _settingArea(context),
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

  Widget _settingArea(BuildContext context) {
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