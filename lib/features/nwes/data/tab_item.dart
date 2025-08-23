import 'package:flutter/material.dart';
import 'package:news/features/nwes/logic/source_model.dart';

class TabItem extends StatelessWidget {
  SourceModel source;
  bool isSelected;
  TabItem({required this.isSelected, required this.source});

  @override
  Widget build(BuildContext context) {
    TextTheme text = Theme.of(context).textTheme;
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return Text(
      source.name,
      style: isSelected ? text.titleMedium : text.titleSmall,
    );
  }
}
