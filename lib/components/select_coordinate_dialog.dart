import 'dart:io' show File;
import 'dart:math' as math;

import 'package:flutter/material.dart';

class SelectCoordinateDialog extends StatefulWidget {
  const SelectCoordinateDialog({
    super.key,
    this.title = 'Select Coordinate',
    required this.imagePath,
  });

  final String title;
  final String imagePath;

  @override
  State<SelectCoordinateDialog> createState() => _SelectCoordinateDialogState();
}

class _SelectCoordinateDialogState extends State<SelectCoordinateDialog> {
  final TransformationController _controller = TransformationController();
  final GlobalKey _imageKey = GlobalKey();
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

  // Converts a tap local position (in widget space, pre-zoom) to image pixel
  // coordinates by reversing the BoxFit.contain transform.
  Offset? _toImageCoordinates(Offset localPosition) {
    if (_imageIntrinsicSize == Size.zero) return null;

    final renderBox =
        _imageKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return null;

    final widgetSize = renderBox.size;
    final iW = _imageIntrinsicSize.width;
    final iH = _imageIntrinsicSize.height;

    final scale = math.min(widgetSize.width / iW, widgetSize.height / iH);
    final offsetX = (widgetSize.width - iW * scale) / 2;
    final offsetY = (widgetSize.height - iH * scale) / 2;

    // details.localPosition is already in scene coordinates — Flutter's hit
    // testing applies the InteractiveViewer's inverse transform automatically,
    // so calling toScene() here would double-transform and introduce an offset.
    return Offset(
      ((localPosition.dx - offsetX) / scale).clamp(0.0, iW),
      ((localPosition.dy - offsetY) / scale).clamp(0.0, iH),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: InteractiveViewer(
        boundaryMargin: EdgeInsets.all(20),
        minScale: 0.5,
        maxScale: 4.0,
        transformationController: _controller,
        child: GestureDetector(
          key: _imageKey,
          onTapUp: (details) {
            final coord = _toImageCoordinates(details.localPosition);
            if (coord != null) Navigator.of(context).pop(coord);
          },
          child: Image.file(File(widget.imagePath), fit: BoxFit.contain),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(null),
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
