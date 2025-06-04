import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:komik/service/utils/permissions_manager.dart';

class FileManager {
  late Directory _root;

  final PermissionsManager _permissionManager;
  final StreamController<FileSystemEntity> controller = StreamController<FileSystemEntity>();
  
  FileManager({
    required PermissionsManager permission_manager,
  }) : _permissionManager = permission_manager;

  Future<void> createComicsFolder() async {
    print("CRIANDO DIRETORIO COMICS");
    print("PERIMISSÃO >>>> ${_permissionManager.haveStorageAccess}");
    if (_permissionManager.haveStorageAccess) {
      final directory = await getExternalStorageDirectory();
      
      if (directory != null) {
        _root = directory;
        await Directory('${directory.path}/Comics').create(recursive: true);
        print("DIRECTORY CREATED");
      }

      print(directory?.path);
    }
  }

  Stream<File> fetch() async* {
    if (_permissionManager.haveStorageAccess) {
      try {
        print(_root.path);
        final directory = Directory('${_root.path}/Comics');
 
        final files = await directory.list().toList();
                
        for (final file in files) {
          if (isComicFile(file as File)) {
            await _renameCBR(file);
            yield file;
          }
        }

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

  _renameCBR(File file) async {
    if (file.path.endsWith('.cbr')) {
      await file.rename(file.path.replaceAll('.cbr', '.cbz'));
    }
  }

}