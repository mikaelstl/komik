import 'package:flutter/material.dart';
import 'package:komik/assets/palette.dart';

class ActionButtonText extends StatelessWidget {
  final String text;

  const ActionButtonText(this.text, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        color: Palette.details,
      ),
    );
  }
}