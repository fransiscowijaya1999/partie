class SearchQuery {
  static List<String> tokenize(String query) {
    return query
        .trim()
        .split(RegExp(r'\s+'))
        .where((t) => t.isNotEmpty)
        .toList();
  }

  static bool matchesAll(String text, List<String> tokens) {
    final haystack = text.toUpperCase();
    return tokens.every((t) => haystack.contains(t.toUpperCase()));
  }
}
