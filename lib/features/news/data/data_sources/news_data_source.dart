import 'package:news/features/news/data/models/news_response/news.dart';

abstract class NewsDataSource {
  Future<List<News>> getNews(String sourceId);
}
