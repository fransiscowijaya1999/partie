import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:partie/components/catalog_dot_dialog.dart';
import 'package:partie/models/part_child.dart';

class CatalogView extends StatefulWidget {
  const CatalogView({
    super.key,
    required this.imagePath,
    this.items = const [],
  });

  final String imagePath;
  final List<PartChild> items;

  @override
  State<CatalogView> createState() => _CatalogViewState();
}

class _CatalogViewState extends State<CatalogView> {
  final TransformationController _controller = TransformationController();
  Size _imageIntrinsicSize = Size.zero;

  @override
  void initState() {
    super.initState();
    _loadImageSize();
  }

  void _loadImageSize() {
    final provider = FileImage(File(widget.imagePath));
    final stream = provider.resolve(ImageConfiguration.empty);
    late ImageStreamListener listener;
    listener = ImageStreamListener((ImageInfo info, bool _) {
      if (mounted) {
        setState(() {
          _imageIntrinsicSize = Size(
            info.image.width.toDouble(),
            info.image.height.toDouble(),
          );
        });
      }
      stream.removeListener(listener);
    });
    stream.addListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      boundaryMargin: EdgeInsets.all(20),
      minScale: 0.5,
      maxScale: 4.0,
      transformationController: _controller,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // With BoxFit.contain + tight width + loose height, the image fills
          // the full width with no horizontal letterboxing. The uniform scale
          // from image pixels to display pixels is width / intrinsicWidth.
          final scale =
              _imageIntrinsicSize.width > 0
                  ? constraints.maxWidth / _imageIntrinsicSize.width
                  : 1.0;

          return Stack(
            children: [
              Image.file(File(widget.imagePath), fit: BoxFit.contain),
              ...widget.items.map(
                (item) => Positioned(
                  top: item.topCoordinate! * scale - 7.5,
                  left: item.leftCoordinate! * scale - 7.5,
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder:
                            (context) => CatalogDotDialog(
                              name: item.name,
                              qty: item.qty,
                              description: item.description,
                              image: item.image,
                            ),
                      );
                    },
                    child: Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue.withAlpha(150),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
