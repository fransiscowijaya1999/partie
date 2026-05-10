import 'dart:typed_data';

class PartChild {
  const PartChild({
    required this.partId,
    required this.isCategory,
    required this.name,
    this.itemId,
    this.partItemId,
    this.qty = '',
    this.description = '',
    this.topCoordinate,
    this.leftCoordinate,
    this.image,
  });

  final int partId;
  final bool isCategory;
  final int? itemId;
  final int? partItemId;
  final String name;
  final String qty;
  final String description;
  final double? topCoordinate;
  final double? leftCoordinate;
  final Uint8List? image;
}
