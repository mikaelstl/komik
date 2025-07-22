import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/components/cards/reading_comic_card.dart';
import 'package:komik/components/texts/base_text.dart';
import 'package:komik/l10n/app_localizations.dart';
import 'package:komik/service/dto/comic_reader_infos.dart';
import 'package:komik/service/managers/reading_manager.dart';

class ReadingPage extends StatefulWidget {
  final ReadingManager readingManager;

  const ReadingPage({
    super.key,
    required this.readingManager
  });

  @override
  State<ReadingPage> createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: StreamBuilder(
          stream: widget.readingManager.fetch(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return _notFounded();
            }

            return Column(
              spacing: 12,
              children: snapshot.data!.map(
                (reading) => ReadingComicCard(
                  width: double.infinity,
                  title: reading.comic.target!.title,
                  edition: reading.comic.target!.edition,
                  thumb: reading.comic.target!.thumb,
                  actualPage: reading.actualPage+1,
                  totalPages: reading.totalPages,
                  callback: () {
                    final infos = ComicReaderInfos();
                      infos.comicID = reading.comic.target!.id;
                      infos.title = reading.comic.target!.title;
                      infos.path = reading.comic.target!.path;
                      infos.initPage = reading.actualPage;
                    Navigator.pushNamed(
                      context,
                      '/reader',
                      arguments: infos
                    );
                  },
                )
              ).toList()
            );
          }
        )
      )
    );
  }

  Widget _notFounded() {
    return Center(
      child: Column(
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
          BaseText(AppLocalizations.of(context)!.no_reading)
        ],
      ),
    );
  }
}