import 'package:flutter/material.dart';
import 'package:komik/assets/palette.dart';

class Label extends StatelessWidget {
  final String text;

  const Label(this.text, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        color: Palette.white,
        fontWeight: FontWeight.w600
      ),
    );
  }
}