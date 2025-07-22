import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/components/buttons/options_btn.dart';
import 'package:komik/components/cards/comic_thumb.dart';
import 'package:komik/components/texts/base_text.dart';
import 'package:komik/components/texts/subtitle.dart';
import 'package:komik/l10n/app_localizations.dart';

class ReadingComicCard extends StatelessWidget {
  final double width;

  final String    title;
  final String    edition;
  final Uint8List thumb;
  final int       actualPage;
  final int       totalPages;
  final Function() callback;

  const ReadingComicCard({
    super.key,
    this.width = 332,
    required this.title,
    required this.edition,
    required this.thumb,
    required this.actualPage,
    required this.totalPages,
    required this.callback
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback(),
      child: Container(
        width: width,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Palette.transparent,
        ),
        height: 145,
        child: Row (
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            ComicThumb(
              height: double.infinity,
              thumb: MemoryImage(thumb),
            ),
            _title(context),
            OptionsBtn()
          ],
        ),
      ),
    );
  }

  Widget _title(BuildContext ctx) {
    return Expanded(
      child: Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Column (
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseText(title),
          _subtitles(ctx)
        ],
      )
    )
    );
  }

  Widget _subtitles(BuildContext ctx) {
    final editionTxt = AppLocalizations.of(ctx)!.edition;
    final page = AppLocalizations.of(ctx)!.page;

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Subtitle('$editionTxt $edition'),
          Subtitle('$page $actualPage / $totalPages')
        ],
      )
    );
  }
}
