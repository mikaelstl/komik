import 'package:flutter/material.dart';
import 'package:komik/assets/palette.dart';

class Titles extends StatelessWidget {
  final String text;

  const Titles(this.text, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18,
        color: Palette.white,
        fontWeight: FontWeight.w900
      )
    );
  }
}