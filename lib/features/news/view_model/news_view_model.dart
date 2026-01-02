import 'package:flutter/widgets.dart';
import 'package:news/Shared/widgets/service_locator.dart';
import 'package:news/features/news/data/models/news_response/news.dart';
import 'package:news/features/news/data/repositories/news_repository.dart';

class NewsViewModel with ChangeNotifier {
  NewsRepository newsRepo = ServiceLocator.newsRepository;
  List<News> newsList = [];
  String? errorMessage;
  bool isLoading = false;
  Future<void> getNews(String sourceId) async {
    isLoading = true;
    notifyListeners();
    try {
      newsList = await newsRepo.getNews(sourceId);
    } catch (e) {
      errorMessage = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
