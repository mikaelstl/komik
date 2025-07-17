import 'package:flutter/material.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/components/texts/language_text.dart';
import 'package:komik/components/texts/option_text.dart';

class IdiomTile extends StatelessWidget {
  final String idiom;
  final String code;
  final Function action;

  const IdiomTile({
    super.key,
    required this.idiom,
    required this.code,
    required this.action
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 2,
            color: Palette.comic_icon
          )
        )
      ),
      child: ListTile(
        onTap: () => action(),
        contentPadding: EdgeInsets.all(16),
        title: OptionText(idiom),
        trailing: LanguageText(code)
      ),
    );
  }
}