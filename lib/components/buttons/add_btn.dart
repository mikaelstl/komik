import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:komik/assets/palette.dart';

class AddBtn extends StatelessWidget {
  final Function() action;
  const AddBtn({
    super.key,
    required this.action
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: action, 
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        backgroundColor: Palette.details,
        elevation: 0
      ),
      icon: HeroIcon(
        HeroIcons.plus,
        color: Palette.white,
        size: 32,
      )
    );
  }
}