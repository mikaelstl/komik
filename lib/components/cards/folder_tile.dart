import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/components/texts/option_text.dart';

class FolderTile extends StatelessWidget {
  const FolderTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 2,
            color: Palette.comic_icon
          )
        )
      ),
      child: ListTile(
        onTap: () => debugPrint('Open modal to delete folder'),
        contentPadding: EdgeInsets.all(16),
        leading: HeroIcon(
          HeroIcons.folder,
          style: HeroIconStyle.solid,
          color: Palette.white,
          size: 24,
        ),
        title: OptionText('Pasta'),
        trailing: HeroIcon(
          HeroIcons.minusCircle,
          style: HeroIconStyle.solid,
          color: Palette.details,
          size: 24,
        ),
      ),
    );
  }
}