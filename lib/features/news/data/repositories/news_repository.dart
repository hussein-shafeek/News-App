import 'package:news/features/news/data/data_sources/news_data_source.dart';
import 'package:news/features/news/data/models/news_response/news.dart';

class NewsRepository {
  NewsDataSource dataSource;
  NewsRepository(this.dataSource);
  Future<List<News>> getNews(String sourceId) async {
    return dataSource.getNews(sourceId);
  }
}
