import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/assets/typography.dart';
import 'package:komik/components/buttons/options_btn.dart';
import 'package:komik/components/cards/comic_thumb.dart';
import 'package:komik/service/utils/color_picker.dart';

class ReadingComicCard extends StatefulWidget {
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
  State<ReadingComicCard> createState() => _ReadingComicCardState();
}

class _ReadingComicCardState extends State<ReadingComicCard> {
  Color background = Palette.items;

  @override
  void initState() {
    super.initState();
    ColorPicker.pickDominantColor(image: MemoryImage(widget.thumb)).then(
      (color) => setState(() {
        background = color;
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.callback(),
      child: Container(
        width: widget.width,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Palette.items,
        ),
        height: 145,
        child: _content(),
      ),
    );
  }

  Widget _content() {
    return Row (
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        ComicThumb(
          height: double.infinity,
          thumb: MemoryImage(widget.thumb),
        ),
        _title(),
        OptionsBtn()
      ],
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
          Text(widget.title, style: KomikTypography.card_title),
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
          Text('Edição ${widget.edition}', style: KomikTypography.subtitles),
          Text('Página ${widget.actualPage} / ${widget.totalPages}', style: KomikTypography.subtitles)
        ],
      )
    );
  }
}
