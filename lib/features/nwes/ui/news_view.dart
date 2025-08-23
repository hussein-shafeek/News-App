import 'package:flutter/material.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/features/nwes/data/news_item.dart';
import 'package:news/features/nwes/data/tab_item.dart';
import 'package:news/features/nwes/logic/source_model.dart';

class NewsView extends StatefulWidget {
  const NewsView({super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  List<SourceModel> sources = List.generate(
    10,
    (index) => SourceModel(id: '$index', name: 'source $index'),
  );
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTabController(
          length: sources.length,
          child: TabBar(
            tabs: sources
                .map(
                  (source) => TabItem(
                    isSelected: currentIndex == sources.indexOf(source),
                    source: source,
                  ),
                )
                .toList(),
            onTap: (index) {
              setState(() {
                if (currentIndex == index) return;
                currentIndex = index;
              });
            },
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            labelPadding: EdgeInsetsDirectional.only(start: 16),
            indicatorColor: AppColors.white,
            dividerColor: Colors.transparent,
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.only(top: 16, left: 16, right: 16),
            itemBuilder: (_, index) => NewsItem(),
            separatorBuilder: (_, _) => SizedBox(height: 16),
            itemCount: 10,
          ),
        ),
      ],
    );
  }
}
