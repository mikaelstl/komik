import 'dart:async';
import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:komik/service/config/user_settings_controller.dart';
import 'package:komik/service/types/root.dart';
import 'package:komik/service/utils/comic_loader.dart';
import 'package:komik/service/utils/permissions_manager.dart';

class FileManager {
  final ComicLoader _comicLoader;
  final PermissionsManager _permissionManager;
  // final StreamController<FileSystemEntity> controller = StreamController<FileSystemEntity>();
  final UserSettingsController settingsController;
  
  FileManager({
    required ComicLoader comic_loader,
    required PermissionsManager permission_manager,
    required UserSettingsController settings_controller
  }) : _comicLoader = comic_loader, _permissionManager = permission_manager, settingsController = settings_controller;

  Future<void> createComicsFolder() async {
    if (_permissionManager.haveStorageAccess) {
      await Directory('${Root.path}/Comics').create(recursive: true);
    }
  }

  Future<void> fetch() async {
    if (_permissionManager.haveStorageAccess) {
      try {
        final path = await ExternalPath.getExternalStoragePublicDirectory(settingsController.defaultFolder);
        
        final directory = Directory(path);
 
        final files = directory
                      .list(recursive: true, followLinks: false);

        files.listen(
          (file) {
            file as File;
            if (isComicFile(file)) {
              _comicLoader.load(file);
            }
          },
          onDone: () {
            debugPrint('BUSCA CONCLUÍDA');
            // _comicLoader.setAmount();
          },
          onError: (err) => debugPrint('ERRO >>> $err')
        );

      } catch (err) {
        throw Exception(err);
      }
    } else {
      _permissionManager.request();
    }
  }

  bool isComicFile(File file) {
    if (file.path.endsWith('.cbz') || file.path.endsWith('.cbr')) {
      return true;
    } else {
      return false;
    }
  }

  // _renameCBR(File file) async {
  //   if (file.path.endsWith('.cbr')) {
  //     await file.rename(file.path.replaceAll('.cbr', '.cbz'));
  //   }
  // }

}