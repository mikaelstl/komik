import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/components/cards/setting_tile.dart';
import 'package:komik/components/texts/language_text.dart';
import 'package:komik/components/texts/option_text.dart';
import 'package:komik/components/texts/subtitle.dart';
import 'package:komik/components/texts/toolbar_title.dart';
import 'package:komik/components/tool-bars/settings_toolbar.dart';
import 'package:komik/l10n/app_localizations.dart';
import 'package:komik/service/config/user_settings_controller.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late UserSettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    settingsController = Provider.of<UserSettingsController>(context);
    return Scaffold(
      appBar: SettingsToolBar(
        title: ToolbarTitle(AppLocalizations.of(context)!.settings)
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
            _divider(),
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
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SettingTile(
          icon: HeroIcons.language,
          label: AppLocalizations.of(context)!.idioms,
          trailing: LanguageText(settingsController.language),
          action: () => Navigator.pushNamed(context, '/idioms')
        ),
      );
  }

  Widget _defaultFolder(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          SettingTile(
            icon: HeroIcons.folder,
            label: AppLocalizations.of(context)!.file_location,
            trailing: HeroIcon(
              HeroIcons.arrowPath,
              color: Palette.white,
              style: HeroIconStyle.solid,
              size: 26,
            ),
            action: () => debugPrint("OPEN FOLDER SELECTOR")
          ),
          _suboption()
        ],
      ),
    );
  }

  Widget _suboption(){
    return Row(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OptionText(settingsController.defaultFolder),
                Subtitle(
                  '000 ${AppLocalizations.of(context)!.comics}',
                )
              ],
            ),
          )
        ],
    );
  }
}