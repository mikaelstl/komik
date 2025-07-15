import 'package:flutter/material.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/components/texts/base_text.dart';

class TextInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const TextInputField({
    super.key,
    required this.label,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseText(label),
          TextField(
            controller: controller,
            style: TextStyle(
              fontSize: 16,
              color: Palette.white,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Palette.items,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8)
              )
            ),
          )
        ],
      ),
    );
  }
}