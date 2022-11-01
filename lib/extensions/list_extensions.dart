extension ListExtensions on List{
  void replaceAt(int index, replacement){
    this[index] = replacement;
  }

  void replaceWith(original, replacement) {
    replaceAt(indexOf(original), replacement);
  }
}