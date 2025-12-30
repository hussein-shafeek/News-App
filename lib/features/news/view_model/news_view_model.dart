import 'package:flutter/widgets.dart';
import 'package:news/features/news/data/data_sources/news_data_source.dart';
import 'package:news/features/news/data/models/news_response/news.dart';
import 'package:news/features/news/data/models/news_response/news_response.dart';

class NewsViewModel with ChangeNotifier {
  NewsDataSource dataSource = NewsDataSource();
  List<News> newsList = [];
  String? errorMessage = '';
  bool isLoading = false;
  Future<void> getNews(String sourceId) async {
    isLoading = true;
    try {
      NewsResponse response = await dataSource.getNews(sourceId);
      if (response.status == 'ok' && response.newsList != null) {
        newsList = response.newsList!;
      } else {
        errorMessage = 'Failed to get news';
      }
    } catch (e) {
      errorMessage = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
