interface class ManagerQueries<T> {
  external int create({ required  data });

  external Stream<List<T>> fetch();

  external T? get({ required int id });

  external Stream<List<T>> search({
    required String title
  });

  external void edit({
    required int id,
    required update
  });

  external Future<bool> haveNoData();
}