import 'package:flutter/material.dart';
import 'package:komik/objectbox.g.dart';
import 'package:komik/service/database/models/comic.dart';
import 'package:komik/service/dto/create_comic.dart';
import 'package:komik/service/utils/interfaces/search_query.dart';

class ComicManager implements SearchQuery<Comic> {
  late Box<Comic> _box;

  ComicManager({
    required Box<Comic> box
  }) : _box = box;

  int create({
    required CreateComicDTO data
  }) {
    final comic = Comic(
      title: data.title,
      subtitle: data.subtitle,
      edition: data.edition,
      thumb: data.thumb,
      path: data.path,
    )..collection.target = data.collection;

    return _box.put(comic);
  }

  Stream<List<Comic>> fetch() {
    debugPrint('INIT TO FETCH COMICS IN DATABASE');
    
    return _box
            .query()
            .watch(triggerImmediately: true)
            .map((q) => q.find());
  }

  Comic? get({ required int id }) {
    return _box.get(id);
  }

  @override
  Stream<List<Comic>> search({
    required String pattern
  }) {
    return _box
            .query(Comic_.title.contains(pattern.trim()))
            .watch(triggerImmediately: true)
            .map((value) => value.find());
  }

  void edit({
    required int id,
    required CreateComicDTO update
  }) {
    final comic = _box.get(id);

    if (comic != null) {
      
    }
  }

  bool haveNoData(){
    return _box.count() == 0;
  }
}