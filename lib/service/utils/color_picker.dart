import 'package:flutter/material.dart';
import 'package:komik/assets/palette.dart';
import 'package:palette_generator/palette_generator.dart';

class ColorPicker {
  static Future<Color> pickDominantColor({ required MemoryImage image }) async {
    final dominant = await PaletteGenerator.fromImageProvider(image);

    return dominant.dominantColor?.color ?? Palette.items;
  }
}