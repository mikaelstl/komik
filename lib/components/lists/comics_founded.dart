import 'package:flutter/material.dart';
import 'package:komik/components/cards/comic_card.dart';
import 'package:komik/components/devider/section_devider.dart';
import 'package:komik/service/database/models/comic.dart';
import 'package:komik/service/dto/comic_reader_infos.dart';

class ComicsFounded extends StatelessWidget {
  final bool _withSection;
  final List<Comic> comics;

  const ComicsFounded({
    super.key,
    required this.comics,
    required bool with_section
  }) : _withSection = with_section;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _withSection
          ? SectionDevider(
            text: '${comics.length} Quadrinhos',
          ) : Container(),
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
}