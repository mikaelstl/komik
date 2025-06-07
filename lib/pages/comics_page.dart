import 'package:flutter/material.dart';
import 'package:komik/components/cards/comic_card.dart';
import 'package:komik/components/labels/not_found_comics.dart';
import 'package:komik/service/database/models/comic.dart';
import 'package:komik/service/dto/comic_reader_infos.dart';
import 'package:komik/service/managers/comic_manager.dart';

class ComicsPage extends StatelessWidget {
  final ComicManager comicManager;

  const ComicsPage({
    super.key,
    required this.comicManager
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      height: double.infinity,
      child: StreamBuilder(
        stream: comicManager.fetch(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: NotFoundComics()
            );
          }
          return _comics(context, snapshot.data!);
        })
      );
  }

  Widget _comics(BuildContext context, List<Comic> comics) {
    return SingleChildScrollView(
        clipBehavior: Clip.none,
        child: Column(
          spacing: 12,
          children: comics.map(
            (comic) => ComicCard(
              title: comic.title,
              subtitle: comic.subtitle,
              edition: 'Edição ${comic.edition}',
              thumb: comic.thumb,
              callback: () => toReader(comic, context),
            )
          ).toList()),
        );
  }

  void toReader(Comic comic, BuildContext ctx) {
    final infos = ComicReaderInfos();
      infos.comicID = comic.id;
      infos.title = comic.title;
      infos.path = comic.path;
      infos.initPage = 0;
    Navigator.pushNamed(
      ctx,
      '/reader',
      arguments: infos
    );
  }
}