import 'package:flutter/material.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/components/texts/base_text.dart';
import 'package:komik/service/utils/enums/comic_type_enum.dart';

class SelectTypeDropdown extends StatefulWidget {
  const SelectTypeDropdown({
    super.key,
  });

  @override
  State<SelectTypeDropdown> createState() => _SelectTypeDropdownState();
}

class _SelectTypeDropdownState extends State<SelectTypeDropdown> {
  ComicTypeEnum selected = ComicTypeEnum.edition;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 118,
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseText('Tipo'),
          _dropdown()
        ],
      ),
    );
  }

  Widget _dropdown(){
    return DropdownButtonFormField(
      style: TextStyle(
        fontSize: 16,
        color: Palette.white,
      ),
      items: [
        DropdownMenuItem(
          value: ComicTypeEnum.edition,
          child:Text('Edição')
        ),
        DropdownMenuItem(
          value: ComicTypeEnum.book,
          child:Text('Livro')
        )
      ],
      dropdownColor: Palette.items,
      decoration: InputDecoration(
        filled: true,
        fillColor: Palette.items,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8)
        )
      ),
      onChanged: (value){}
    );
  }
}