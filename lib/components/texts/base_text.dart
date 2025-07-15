import 'package:flutter/material.dart';
import 'package:komik/assets/palette.dart';

class BaseText extends StatelessWidget {
  final String text;
  final bool? softWrap;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextAlign? textAlign;

  const BaseText(this.text, {
    super.key,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      softWrap: softWrap,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: 16,
        color: Palette.white,
      ),
    );
  }
}