import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/assets/typography.dart';
import 'package:komik/components/buttons/options_btn.dart';
import 'package:komik/components/cards/comic_thumb.dart';

class CollectionCard extends StatelessWidget {
  final String        title;
  final List<String>  editions;
  final Uint8List     thumb;
  
  final Function() callback;
  const CollectionCard({
    super.key,
    required this.title,
    required this.editions,
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
        _infos(),
        OptionsBtn()
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

  Widget _infos() {
    return Expanded(
      child: Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Column (
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: KomikTypography.card_title),
          Text('Edições ${editions.first} - ${editions.last}', style: KomikTypography.subtitles),
        ],
      )
    )
    );
  }
}
