import 'package:flutter/material.dart';
import 'package:komik/components/cards/collection_card.dart';
import 'package:komik/components/devider/section_devider.dart';
import 'package:komik/l10n/app_localizations.dart';
import 'package:komik/service/database/models/collection.dart';

class CollectionsFounded extends StatelessWidget {
  final bool _withSection;
  final List<Collection> collections;

  const CollectionsFounded({
    super.key,
    required this.collections,
    required bool with_section
  }) : _withSection = with_section;

  @override
  Widget build(BuildContext context) {
    final collectionsTxt = AppLocalizations.of(context)!.collections;
    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _withSection
          ? SectionDevider(
            text: '${collections.length} $collectionsTxt',
          ) : Container(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            spacing: 12,
            children: collections.map( 
              (collection) {
                collection.comics.sort((a,b) => a.edition.compareTo(b.edition)); 
                return CollectionCard(
                  title: collection.title,
                  editions: [collection.comics.first.edition, collection.comics.last.edition],
                  thumb: collection.comics.first.thumb,
                  callback: () => Navigator.pushNamed(context, '/collection', arguments: collection)
                );
              }
            ).toList()
          ),  
        )
      ]
    );
  }
}