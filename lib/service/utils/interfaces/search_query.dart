interface class SearchQuery<T> {
  external Stream<List<T>> search({
    required String pattern
  });
}