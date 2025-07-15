import 'package:flutter/material.dart';
import 'package:komik/assets/palette.dart';

class Subtitle extends StatelessWidget {
  final String text;

  const Subtitle(this.text, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        color: Palette.subtitles,
      ),
    );
  }
}