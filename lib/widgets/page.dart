import 'dart:typed_data';

import 'package:flutter/material.dart';

class PageViewer extends StatelessWidget {
  final TransformationController _controller;
  final Uint8List image;

  PageViewer({
    super.key,
    required this.image,
    required TransformationController transformationController
  }) : _controller = transformationController;

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      transformationController: _controller,
      panEnabled: true,
      scaleEnabled: true,
      child: Image.memory(image)
    );
  }
}
