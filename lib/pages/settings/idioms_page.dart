import 'package:flutter/material.dart';
import 'package:komik/components/cards/idiom_tile.dart';
import 'package:komik/components/texts/option_text.dart';
import 'package:komik/components/tool-bars/settings_toolbar.dart';
import 'package:komik/l10n/app_localizations.dart';
import 'package:komik/service/config/user_settings.dart';
import 'package:komik/service/config/user_settings_controller.dart';
import 'package:provider/provider.dart';

class IdiomsPage extends StatefulWidget {
  final List<Locale> idioms;

  const IdiomsPage(this.idioms, {super.key});

  @override
  State<IdiomsPage> createState() => _IdiomsPageState();
}

class _IdiomsPageState extends State<IdiomsPage> {
  final UserSettings userSettings = UserSettings.getInstance();

  late UserSettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    settingsController = Provider.of<UserSettingsController>(context);

    return Scaffold(
      appBar: SettingsToolBar(
        title: OptionText(AppLocalizations.of(context)!.idioms)
      ),
      body: SingleChildScrollView(
        child: Column(
          children: widget.idioms.map((idiom) => IdiomTile(
            idiom: userSettings.getLanguageName(idiom.languageCode),
            code: idiom.languageCode,
            action: () {
              settingsController.setLanguage(idiom.languageCode).then(
                (_) => Navigator.pop(context)
              );
            }
          )).toList(),
        ),
      ),
    );
  }
}