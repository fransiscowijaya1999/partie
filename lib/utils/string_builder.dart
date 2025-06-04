class StringBuilder {
  static String titleBuilder(String base, String current) {
    return base.isEmpty ? current : '$base \\ $current';
  }
}