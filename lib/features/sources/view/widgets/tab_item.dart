import 'package:flutter/material.dart';
import 'package:news/features/sources/data/models/sources_response/source.dart';

class TabItem extends StatelessWidget {
  final Source source;
  final bool isSelected;
  const TabItem({super.key, required this.isSelected, required this.source});

  @override
  Widget build(BuildContext context) {
    TextTheme text = Theme.of(context).textTheme;
    // double width = MediaQuery.sizeOf(context).width; // Unused
    // double height = MediaQuery.sizeOf(context).height; // Unused
    return Text(
      source.name ?? '',
      style: isSelected ? text.titleMedium : text.titleSmall,
    );
  }
}
