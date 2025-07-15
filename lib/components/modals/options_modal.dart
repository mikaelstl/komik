import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/components/texts/option_text.dart';

class OptionsModal extends StatelessWidget {
  const OptionsModal({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
      decoration: BoxDecoration(
        color: Palette.items,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(8))
      ),
      child: Column(
        children: [
          _divider(),
          _options(context)
        ]
      ),
    ),
    );
  }

  Widget _options(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _option(
            label: 'Editar',
            icon: HeroIcons.pencil,
            action: () => Navigator.pushNamed(context, '/edit-comic')
          ),
          _option(
            label: 'Ir para coleção',
            icon: HeroIcons.bookmarkSquare,
            action: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/collection');
            }
          ),
          _option(
            label: 'Excluir',
            icon: HeroIcons.trash,
            action: (){}
          )
        ],
      )
    );
  }

  Widget _divider() {
    return Container(
      width: 125,
      height: 2,
      margin: const EdgeInsets.only(top: 12, bottom: 30),
      color: Palette.details,
    );
  }

  Widget _option({
    required String label,
    required HeroIcons icon,
    required Function() action
  }) {
    return TextButton.icon(
      onPressed: action,
      icon: HeroIcon(
        icon,
        color: Palette.white,
        style: HeroIconStyle.solid,
      ),
      label: OptionText(label)
    );
  }
}