import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/features/news/data/models/news_response/news.dart';
import 'package:news/features/news/view_model/news_states.dart';
import 'package:news/features/news/view_model/news_view_model.dart';
import 'package:news/features/sources/data/models/sources_response/source.dart';
import 'package:news/Shared/theme/app_colors.dart';
import 'package:news/Shared/widgets/error_indicator.dart';
import 'package:news/Shared/widgets/loading_indicator.dart';
import 'package:news/features/news/view/widgets/news_item.dart';
import 'package:news/features/sources/view_model/sources_states.dart';
import 'package:news/features/sources/view_model/sources_view_model.dart';
import 'package:news/features/sources/view/widgets/tab_item.dart';

class NewsView extends StatefulWidget {
  final String categoryId;
  const NewsView({super.key, required this.categoryId});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SourcesViewModel()..getSources(widget.categoryId),
      child: BlocBuilder<SourcesViewModel, SourcesStates>(
        builder: (context, state) {
          if (state is SourcesLoading) {
            return const LoadingIndicator();
          } else if (state is SourcesError) {
            return ErrorIndicator(state.message);
          } else if (state is SourcesSuccess) {
            List<Source> sources = state.sources;
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
                    labelPadding: const EdgeInsetsDirectional.only(start: 16),
                    indicatorColor: AppColors.white,
                    dividerColor: Colors.transparent,
                  ),
                ),
                Expanded(
                  child: BlocProvider(
                    key: ValueKey(sources[currentIndex].id),
                    create: (_) =>
                        NewsViewModel()..getNews(sources[currentIndex].id!),
                    child: BlocBuilder<NewsViewModel, NewsStates>(
                      builder: (context, state) {
                        if (state is NewsLoading) {
                          return const LoadingIndicator();
                        } else if (state is NewsError) {
                          return ErrorIndicator(state.message);
                        } else if (state is NewsSuccess) {
                          List<News> newsList = state.newsList;
                          return ListView.separated(
                            itemBuilder: (_, index) =>
                                NewsItem(newsList[index]),
                            separatorBuilder: (_, _) =>
                                const SizedBox(height: 16),
                            itemCount: newsList.length,
                          );
                        } else {
                          return const Center(child: Text("No news found."));
                        }
                      },
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text("No sources found."));
          }
        },
      ),
    );
  }
}
