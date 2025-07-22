import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/components/buttons/options_btn.dart';
import 'package:komik/components/cards/comic_thumb.dart';
import 'package:komik/components/texts/base_text.dart';
import 'package:komik/components/texts/subtitle.dart';
import 'package:komik/l10n/app_localizations.dart';

class CollectionCard extends StatefulWidget {
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
  State<CollectionCard> createState() => _CollectionCardState();
}

class _CollectionCardState extends State<CollectionCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          widget.callback();
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
        thumb: MemoryImage(widget.thumb),
      ),
    );
  }

  Widget _infos() {
    final editionTxt = AppLocalizations.of(context)!.editions;

    return Expanded(
      child: Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Column (
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BaseText(widget.title),
          Subtitle('$editionTxt ${widget.editions.first} - ${widget.editions.last}'),
        ],
      )
    )
    );
  }
}
