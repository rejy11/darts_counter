extension IterableExtensions<T> on Iterable<T> {
  /// Places an element between each item in a list.
  ///
  /// Set the [start] and [end] params to also place the element at the start or end of the list.
  Iterable<T> intersperse(
    T element, {
    bool start = false,
    bool end = false,
  }) sync* {
    final Iterator<T> iterator = this.iterator;
    if (iterator.moveNext()) {
      if (start) yield element;
      yield iterator.current;
      while (iterator.moveNext()) {
        yield element;
        yield iterator.current;
      }
      if (end) yield element;
    }
  }
}
