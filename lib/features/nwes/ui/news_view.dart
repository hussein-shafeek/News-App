import 'package:flutter/material.dart';
import 'package:news/core/models/news_response/news.dart';
import 'package:news/core/models/sources_response/source.dart';
import 'package:news/core/models/sources_response/sources_response.dart';
import 'package:news/core/services/api/api_service.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/features/nwes/data/error_indicator.dart';
import 'package:news/features/nwes/data/loading_indicator.dart';
import 'package:news/features/nwes/data/news_item.dart';
import 'package:news/features/nwes/data/tab_item.dart';

class NewsView extends StatefulWidget {
  String categoryId;
  NewsView({required this.categoryId});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  int currentIndex = 0;
  late Future<SourcesResponse> getSourcesFuture = ApiService.getSources(
    widget.categoryId,
  );
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getSourcesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingIndicator();
        } else if (snapshot.hasError || snapshot.data?.status != 'ok') {
          return ErrorIndicator();
        } else {
          List<Source> sources = snapshot.data?.sources ?? [];
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
                child: FutureBuilder(
                  future: ApiService.getNews(sources[currentIndex].id!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return LoadingIndicator();
                    } else if (snapshot.hasError ||
                        snapshot.data?.status != 'ok') {
                      return ErrorIndicator();
                    } else {
                      List<News> newsList = snapshot.data?.newsList ?? [];
                      return ListView.separated(
                        padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                        itemBuilder: (_, index) => NewsItem(newsList[index]),
                        separatorBuilder: (_, _) => SizedBox(height: 16),
                        itemCount: newsList.length,
                      );
                    }
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
