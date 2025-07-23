import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/components/modals/options_modal.dart';

class OptionsBtn extends StatelessWidget {
  const OptionsBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return OptionsModal();
          }
        );
      },
      style: IconButton.styleFrom(
        backgroundColor: Palette.details,
        shape: RoundedRectangleBorder(),
        alignment: Alignment.centerLeft,
      ),
      icon: HeroIcon(
        HeroIcons.ellipsisVertical,
        color: Palette.white,
        size: 24,
      ),
    );
  }
}