import 'package:flutter/material.dart';
import 'package:news/core/models/sources_response/source.dart';

class TabItem extends StatelessWidget {
  Source source;
  bool isSelected;
  TabItem({required this.isSelected, required this.source});

  @override
  Widget build(BuildContext context) {
    TextTheme text = Theme.of(context).textTheme;
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return Text(
      source.name ?? '',
      style: isSelected ? text.titleMedium : text.titleSmall,
    );
  }
}
