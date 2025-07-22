import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/components/buttons/go_back_btn.dart';
import 'package:komik/components/cards/comic_thumb.dart';
import 'package:komik/components/cards/comic_tile.dart';
import 'package:komik/components/devider/section_devider.dart';
import 'package:komik/components/texts/action_button_text.dart';
import 'package:komik/components/texts/base_text.dart';
import 'package:komik/components/texts/titles.dart';
import 'package:komik/components/tool-bars/tool_bar.dart';
import 'package:komik/l10n/app_localizations.dart';
import 'package:komik/service/database/models/collection.dart';
import 'package:komik/service/database/models/comic.dart';
import 'package:komik/service/dto/comic_reader_infos.dart';

class CollectionInfoPage extends StatefulWidget {
  
  const CollectionInfoPage({super.key});

  @override
  State<CollectionInfoPage> createState() => _CollectionInfoPageState();
}

class _CollectionInfoPageState extends State<CollectionInfoPage> {
  late Widget actualDescription;

  @override
  void initState() {
    super.initState();
    actualDescription = _shortDescription('');
  }

  @override
  Widget build(BuildContext context) {
    final collection = ModalRoute.of(context)!.settings.arguments as Collection;
    
    return Scaffold(
      appBar: ToolBar(
        leading: GoBackBtn(),
      ),
      body: Container(
        height: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 16),
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: Column(
            spacing: 20,
            children: [
              _infos(collection),
              SectionDevider(text: 'Edições'),
              collection.comics.isNotEmpty ? _comics(collection.comics) : _noComics()
            ],
          )
        )
      ),
    );
  }

  Widget _infos(Collection collection){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ComicThumb(
              thumb: MemoryImage(collection.comics.first.thumb)
            )
          ),
          _details(
            collection.title,
            actualDescription
          )
        ],
      ),
    );
  }

  Widget _details(
    String title,
    Widget descriptionCard
  ){
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Titles(title),
          descriptionCard
        ],
      ),
    );
  }

  Widget _shortDescription(String text) {
    final description = BaseText(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 7,
      textAlign: TextAlign.justify,
    );

    return Column(
      children: [
        description,
        _seeMoreBtn(
          icon: HeroIcons.chevronDown,
          action: () => {
            setState(() => actualDescription = _fullDescription(text))
          }
        )
      ],
    );
  }

  Widget _fullDescription(String text) {
    final description = BaseText(
      text,
      textAlign: TextAlign.justify,
    );

    return Column(
      children: [
        description,
        _seeMoreBtn(
          icon: HeroIcons.chevronUp,
          action: () => {
            setState(() => actualDescription = _shortDescription(text))
          }
        )
      ],
    );
  }

  Widget _comics(List<Comic> comics) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        spacing: 12,
        children: comics.map(
          (comic) => ComicTile(
            subtitle: comic.subtitle,
            edition: comic.edition,
            thumb: comic.thumb,
            callback: () {
              final infos = ComicReaderInfos();
                infos.title = comic.title;
                infos.path = comic.path;
                infos.initPage = 0;
              Navigator.pushNamed(
                context,
                '/reader',
                arguments: infos
              );
            },
          )
        ).toList()
      )
    );
  }

  Widget _noComics() {
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
          BaseText(AppLocalizations.of(context)!.collection_withour_comics),
        ],
      ),
    );
  }

  Widget _seeMoreBtn({
    required HeroIcons icon,
    required Function() action
  }) {
    return TextButton.icon(
      onPressed: (){
        action();
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(0),
        minimumSize: Size(double.infinity, 14)
      ),
      iconAlignment: IconAlignment.end,
      icon: HeroIcon(
        icon,
        color: Palette.details,
        style: HeroIconStyle.micro,
      ),
      label: ActionButtonText('${AppLocalizations.of(context)!.see_more} '),
    );
  }
}