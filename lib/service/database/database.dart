import 'package:flutter/material.dart';
import 'package:komik/service/database/models/collection.dart';
import 'package:komik/service/database/models/comic.dart';
import 'package:komik/service/database/models/reading.dart';
import 'package:objectbox/objectbox.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:komik/objectbox.g.dart';

class DB with ChangeNotifier {
  late Store _store;

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
  
    _store = Store(
      getObjectBoxModel(),
      directory: join(dir.path, 'localdata')
    );
  }

  void reset() {
    _store.box<Reading>().removeAll();
    _store.box<Collection>().removeAll();
    _store.box<Comic>().removeAll();
  }

  void close() {
    _store.close();
  }

  Store get store => _store;
}