import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/assets/typography.dart';
import 'package:komik/components/cards/setting_tile.dart';
import 'package:komik/components/texts/base_text.dart';
import 'package:komik/components/texts/option_text.dart';
import 'package:komik/components/texts/toolbar_title.dart';
import 'package:komik/components/tool-bars/settings_toolbar.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final Map<String, dynamic> userSettings = {
    'automatic-search': false
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SettingsToolBar(
        title: ToolbarTitle('Configurações')
      ),
      body: _content(),
    );
  }

  Widget _content() {
    return Container(
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
              trailing: Text('Pt-BR', style: KomikTypography.language),
              action: () {
                debugPrint('Open language selector modal');
              },
            ),
          ),
          _divider(),
          _settingArea(),
        ],
      ),
    );
  }

  Widget _divider() {
    return Divider(
      color: Palette.comic_icon,
      thickness: 2,
      height: 2,
    );
  }

  Widget _settingArea() {
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
          _suboption(
            title: 'Busca automática',
            subtitle: 'Ativada, irá buscar por quadrinhos por todo o armazenamento do dispositivo. Pode afetar a performance do aplicativo.'
          )
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
          ),
          CupertinoSwitch(
            value: userSettings['automatic-search'],
            activeTrackColor: Palette.details,
            thumbColor: Palette.white,
            inactiveTrackColor: Palette.items,
            onChanged: (bool value) {
              setState(() {
                userSettings['automatic-search'] = value;
              });
            }
          )
        ],
      ),
    );
  }
}