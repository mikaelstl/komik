import 'package:flutter/material.dart';
import 'package:komik/assets/palette.dart';

class ToolbarTitle extends StatelessWidget {
  final String text;

  const ToolbarTitle(this.text, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 24,
        color: Palette.white,
        fontWeight: FontWeight.w900
      )
    );
  }
}