import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/assets/typography.dart';
import 'package:komik/components/buttons/options_btn.dart';
import 'package:komik/components/cards/comic_thumb.dart';

class ComicCard extends StatelessWidget {
  final String    title;
  final String    subtitle;
  final String    edition;
  final Uint8List thumb;
  
  final Function() callback;
  const ComicCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.edition,
    required this.thumb,
    required this.callback
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          callback();
        },
        child: Container(
          color: Palette.transparent,
          height: 126,
          child: _content(),
      ),
    );
  }

  Widget _content() {
    return Row (
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        _leading(),
        _title(),
        /*OptionsBtn()*/Container()
      ],
    );
  }

  Widget _leading() {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ComicThumb(
        thumb: MemoryImage(thumb),
      ),
    );
  }

  Widget _title() {
    return Expanded(
      child: Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Column (
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: KomikTypography.card_title),
          _subtitles()
        ],
      )
    )
    );
  }

  Widget _subtitles() {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subtitle, style: KomikTypography.subtitles),
          Text(edition, style: KomikTypography.subtitles)
        ],
      )
    );
  }
}
