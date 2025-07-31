import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:komik/components/buttons/add_btn.dart';
import 'package:komik/components/cards/folder_tile.dart';
import 'package:komik/components/texts/option_text.dart';
import 'package:komik/components/tool-bars/settings_toolbar.dart';

class LocalFilesPage extends StatelessWidget {
  const LocalFilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SettingsToolBar(
        title: OptionText('Local dos arquivos')
      ),
      body: _content(),
      floatingActionButton: AddBtn(
        action: () async {
          debugPrint('Open file picker');
          String? folder = await FilePicker.platform.getDirectoryPath();
          debugPrint(folder);
        },
      ),
    );
  }

  Widget _content() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(2, (index) => FolderTile()),
        ),
      ),
    );
  }
}