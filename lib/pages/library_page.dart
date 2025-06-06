import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/assets/typography.dart';
import 'package:komik/components/cards/comic_card.dart';
import 'package:komik/components/cards/reading_comic_card.dart';
import 'package:komik/components/devider/section_devider.dart';
import 'package:komik/components/utils/scroller/scroller.dart';
import 'package:komik/service/dto/comic_reader_infos.dart';
import 'package:komik/service/managers/comic_manager.dart';
import 'package:komik/service/database/models/comic.dart';
import 'package:komik/service/managers/reading_manager.dart';

class LibraryPage extends StatelessWidget {
  final ComicManager comicManager;
  final ReadingManager readingManager;

  const LibraryPage({
    super.key,
    required this.comicManager,
    required this.readingManager
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      alignment: Alignment.topCenter,
      child: _content(context)
    );
  }

  Widget _content(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 28,
        children: [
          _reading(),
          _comics(context)
        ]
      )
    );
  }

  Widget _reading() {
    return StreamBuilder(
      stream: readingManager.fetch(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Container();
        }

        return Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionDevider(
              text: 'Lendo',
            ),
            Scroller(
              direction: Axis.horizontal,
              amount: snapshot.data!.length,
              margin: EdgeInsets.symmetric(horizontal: 16),
              children: snapshot.data!.map(
                (reading) => ReadingComicCard(
                  title: reading.comic.target!.title,
                  edition: reading.comic.target!.edition,
                  thumb: reading.comic.target!.thumb,
                  actualPage: reading.actualPage+1,
                  totalPages: reading.totalPages,
                  callback: () {
                    ComicReaderInfos infos = ComicReaderInfos();
                      infos.comicID = reading.comic.target!.id;
                      infos.title = reading.comic.target!.title;
                      infos.path = reading.comic.target!.path;
                      infos.initPage = reading.actualPage;
                      infos.totalPages = reading.totalPages;
                      
                    Navigator.pushNamed(
                      context,
                      '/reader',
                      arguments: infos
                    );
                  },
                ),
              ).toList()
            )
          ],
        );
      }
    );
  }

  Widget _comics(BuildContext context) {
    return StreamBuilder<List<Comic>>(
      stream: comicManager.fetch(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: _notFoundComics()
          );
        }
        return _comicsFounded(context, snapshot.data!);
      }
    );
  }

  Widget _comicsFounded(BuildContext context, List<Comic> comics) {
    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionDevider(
          text: 'Quadrinhos',
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            spacing: 12,
            children: comics.map( 
              (comic) => ComicCard(
                title: comic.title,
                subtitle: comic.subtitle,
                edition: 'Edição ${comic.edition}',
                thumb: comic.thumb,
                callback: () {
                  final infos = ComicReaderInfos();
                    infos.comicID = comic.id;
                    infos.title = comic.title;
                    infos.path = comic.path;
                    infos.initPage = 0;
                  Navigator.pushNamed(
                    context,
                    '/reader',
                    arguments: infos
                  );
                }
              )
            ).toList()
          ),  
        )
      ]
    );
  }

  Widget _notFoundComics() {
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

// 