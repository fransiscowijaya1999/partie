class PartChild {
  const PartChild({
    required this.partId,
    required this.isCategory,
    required this.name,
    this.itemId,
    this.qty = '',
    this.description = ''
  });

  final int partId;
  final bool isCategory;
  final int? itemId;
  final String name;
  final String qty;
  final String description;
}