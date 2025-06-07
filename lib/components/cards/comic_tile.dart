import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:komik/assets/typography.dart';
import 'package:komik/components/cards/comic_thumb.dart';

class ComicTile extends StatelessWidget {
  final String edition;
  final String subtitle;
  final Uint8List thumb;
  final Function() callback;

  const ComicTile({
    super.key,
    required this.edition,
    required this.subtitle,
    required this.thumb,
    required this.callback
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback(),
      child: Row(
        spacing: 12,
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ComicThumb(
              thumb: MemoryImage(thumb),
            ),
          ),
          Text('#$edition', style: KomikTypography.base),
          Text(subtitle, style: KomikTypography.subtitles),
        ],
      ),
    );
  }
}