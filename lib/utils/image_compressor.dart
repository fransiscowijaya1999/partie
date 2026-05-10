import 'dart:typed_data';

import 'package:image/image.dart' as img;

class ImageCompressor {
  static Future<Uint8List?> compressFile(
    String path, {
    int maxDimension = 1024,
    int quality = 75,
  }) async {
    final decoded = await img.decodeImageFile(path);
    if (decoded == null) return null;

    final resized =
        (decoded.width > maxDimension || decoded.height > maxDimension)
            ? img.copyResize(
              decoded,
              width: decoded.width >= decoded.height ? maxDimension : null,
              height: decoded.height > decoded.width ? maxDimension : null,
            )
            : decoded;

    return img.encodeJpg(resized, quality: quality);
  }
}
