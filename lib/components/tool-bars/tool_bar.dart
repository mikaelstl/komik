import 'package:flutter/material.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/components/buttons/menu_btn.dart';
import 'package:komik/components/buttons/search_btn.dart';

class ToolBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget leading;
  const ToolBar({
    super.key,
    required this.leading
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(12)
        )
      ),
      backgroundColor: Palette.items,
      leading: leading,
      actions: [
        SearchBtn(),
        MenuBtn()
      ],
    );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(64);
}