import 'package:komik/objectbox.g.dart';
import 'package:komik/service/database/models/collection.dart';
import 'package:komik/service/utils/interfaces/search_query.dart';

class CollectionManager implements SearchQuery<Collection> {
  final Box<Collection> _box;

  CollectionManager({
    required Box<Collection> box
  }) : _box = box;

  Collection create({
    required String title,
    required String description
  }) {
    final collection = Collection(
      title: title,
      description: description
    );

    _box.put(collection);

    return collection;
  }

  Stream<List<Collection>> fetch() {
    return _box
            .query()
            .watch(triggerImmediately: true)
            .map((value) => value.find());
  }

  Collection? get({
    required int id
  }) {
    return _box.get(id);
  }

  Collection? find({
    required String pattern
  }) {
    return _box
            .query(Collection_.title.contains(pattern.trim()))
            .build()
            .findFirst();
  }

  @override
  Stream<List<Collection>> search({required String pattern}) {
    return _box
            .query(Collection_.title.contains(pattern.trim()))
            .watch(triggerImmediately: true)
            .map((value) => value.find());
  }

  /* void edit({
    required int id,
    required ComicDTO update
  }) {
    final comic = _box.get(id);

    if (comic != null) {
      
    }
  } */
}