import 'package:flutter/material.dart';
import 'package:komik/components/cards/comic_card.dart';
import 'package:komik/components/devider/section_devider.dart';
import 'package:komik/l10n/app_localizations.dart';
import 'package:komik/service/database/models/comic.dart';
import 'package:komik/service/dto/comic_reader_infos.dart';

class ComicsFounded extends StatelessWidget {
  final bool _withSection;
  final List<Comic> comics;

  const ComicsFounded(
      {super.key, required this.comics, required bool with_section})
      : _withSection = with_section;

  @override
  Widget build(BuildContext context) {
    final comicsTxt = AppLocalizations.of(context)!.comics;
    final editionTxt = AppLocalizations.of(context)!.edition;

    return SingleChildScrollView(
      child: Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _withSection
                ? SectionDevider(
                    text: '${comics.length} $comicsTxt',
                  )
                : Container(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                  spacing: 12,
                  children: comics.map((comic) {
                    return ComicCard(
                        title: comic.title,
                        subtitle: comic.subtitle,
                        edition: '$editionTxt ${comic.edition}',
                        thumb: comic.thumb,
                        isReading: comic.reading,
                        callback: () => toReader(comic, context));
                  }).toList()),
            )
          ]),
    );
  }

  void toReader(Comic comic, BuildContext ctx) {
    final infos = ComicReaderInfos();
    infos.comicID = comic.id;
    infos.title = comic.title;
    infos.path = comic.path;
    infos.initPage = 0;
    Navigator.pushNamed(ctx, '/reader', arguments: infos);
  }
}
