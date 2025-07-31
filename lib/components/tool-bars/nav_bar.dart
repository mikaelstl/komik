import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/l10n/app_localizations.dart';

class NavBar extends StatelessWidget {
  final int index;
  final Function(int value) action;
  const NavBar({super.key, required this.index, required this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Palette.details, width: 2))),
      child: NavigationBarTheme(
          data: NavigationBarThemeData(
              labelTextStyle: WidgetStateProperty.all(TextStyle(
            color: Palette.white,
            fontSize: 12,
          ))),
          child: NavigationBar(
            onDestinationSelected: (value) => action(value),
            destinations: [
              NavigationDestination(
                icon: HeroIcon(
                  HeroIcons.home,
                  style: HeroIconStyle.solid,
                  size: 24,
                  color: Palette.white,
                ),
                label: AppLocalizations.of(context)!.home,
              ),
              NavigationDestination(
                icon: HeroIcon(
                  HeroIcons.bookOpen,
                  style: HeroIconStyle.solid,
                  size: 24,
                  color: Palette.white,
                ),
                label: AppLocalizations.of(context)!.comics,
              ),
              NavigationDestination(
                icon: HeroIcon(
                  HeroIcons.wallet,
                  style: HeroIconStyle.solid,
                  size: 24,
                  color: Palette.white,
                ),
                label: AppLocalizations.of(context)!.collections,
              ),
              NavigationDestination(
                icon: HeroIcon(
                  HeroIcons.bookmarkSquare,
                  style: HeroIconStyle.solid,
                  size: 24,
                  color: Palette.white,
                ),
                label: AppLocalizations.of(context)!.reading,
              ),
            ],
            selectedIndex: index,
            backgroundColor: Palette.items,
            indicatorColor: const Color.fromARGB(83, 228, 25, 59),
          )),
    );
  }
}