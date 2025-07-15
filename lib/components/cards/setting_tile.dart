import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/components/texts/option_text.dart';

class SettingTile extends StatelessWidget {
  final HeroIcons icon;
  final String label;
  final Widget trailing;
  final Function() action;
  const SettingTile({
    super.key,
    required this.icon,
    required this.label,
    required this.trailing,
    required this.action
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => action(),
      contentPadding: EdgeInsets.all(0),
      leading: HeroIcon(
        icon,
        style: HeroIconStyle.solid,
        color: Palette.white,
        size: 24,
      ),
      title: OptionText(label),
      trailing: trailing
    );
  }
}