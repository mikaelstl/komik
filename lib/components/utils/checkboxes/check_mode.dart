import 'package:flutter/material.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/components/texts/base_text.dart';
import 'package:komik/service/utils/states/search_filter_type.dart';

class CheckMode extends StatelessWidget {
  final SearchFilterType type;
  final SearchFilterType group;
  final String label;
  final ValueChanged<SearchFilterType> onChanged;

  const CheckMode({
    super.key,
    required this.label,
    required this.type,
    required this.group,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool checked = type == group;
    return InkWell(
      onTap: () {
        onChanged(type);
        debugPrint('type selected: ${type.value}');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: checked ? Palette.details : Palette.items,
          borderRadius: BorderRadius.circular(9999)
        ),
        child: BaseText(label),
      ),
    );
  }
}