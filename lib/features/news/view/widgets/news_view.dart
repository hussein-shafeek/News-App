import 'package:flutter/material.dart';
import 'package:news/features/news/data/models/news_response/news.dart';
import 'package:news/features/news/view_model/news_view_model.dart';
import 'package:news/features/sources/data/models/sources_response/source.dart';
import 'package:news/Shared/services/api/api_service.dart';
import 'package:news/Shared/theme/app_colors.dart';
import 'package:news/Shared/widgets/error_indicator.dart';
import 'package:news/Shared/widgets/loading_indicator.dart';
import 'package:news/features/news/view/widgets/news_item.dart';
import 'package:news/features/sources/view_model/sources_view_model.dart';
import 'package:news/features/sources/view/widgets/tab_item.dart';
import 'package:provider/provider.dart';

class NewsView extends StatefulWidget {
  final String categoryId;
  const NewsView({super.key, required this.categoryId});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  // Source? selectedSource; // Unused
  int currentIndex = 0;
  SourcesViewModel sourcesViewModel = SourcesViewModel();
  NewsViewModel newsViewModel = NewsViewModel();

  @override
  void initState() {
    super.initState();
    sourcesViewModel.getSources(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => sourcesViewModel,
      child: Consumer<SourcesViewModel>(
        builder: (_, viewModel, _) {
          if (viewModel.isLoading) {
            return const LoadingIndicator();
          } else if (viewModel.errorMessage != null) {
            return ErrorIndicator(viewModel.errorMessage!);
          } else {
            List<Source> sources = viewModel.sources;
            if (sources.isEmpty) {
              return const Center(child: Text("No sources found."));
            }
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
                  child: ChangeNotifierProvider(
                    key: ValueKey(sources[currentIndex].id),
                    create: (_) =>
                        newsViewModel..getNews(sources[currentIndex].id!),
                    child: Consumer<NewsViewModel>(
                      builder: (context, viewModel, _) {
                        if (viewModel.isLoading) {
                          return const LoadingIndicator();
                        } else if (viewModel.errorMessage != null) {
                          return ErrorIndicator(viewModel.errorMessage!);
                        } else {
                          List<News> newsList = viewModel.newsList;
                          return ListView.separated(
                            itemBuilder: (_, index) =>
                                NewsItem(newsList[index]),
                            separatorBuilder: (_, _) =>
                                const SizedBox(height: 16),
                            itemCount: newsList.length,
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
