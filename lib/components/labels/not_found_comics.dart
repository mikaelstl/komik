import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/assets/typography.dart';

class NotFoundComics extends StatelessWidget {
  const NotFoundComics({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        HeroIcon(
          HeroIcons.bookmarkSquare,
          size: 52,
          color: Palette.comic_icon,
          style: HeroIconStyle.solid,
        ),
        Text('Nenhum quadrinho encontrado', style: KomikTypography.base),
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.all(0)
              
          ),
          onPressed: () => debugPrint('Go to Files Selector'),
          child: Text('Adicionar', style: KomikTypography.action_button)
        )
      ],
    );
  }
}