import 'package:flutter/material.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/components/texts/label.dart';

class SectionDevider extends StatelessWidget {
  final String text;
  const SectionDevider({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16),
      child: Row(
        spacing: 10,
        children: [
          Label(text),
          Expanded (
            child: Container(
              height: 2,
              color: Palette.details,
            ),
          )
        ],
      )
    );
  }
}