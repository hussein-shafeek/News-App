import 'package:news/features/search/data/data_sources/category_search_data_source.dart';
import 'package:news/features/news/data/models/news_response/news.dart';

class CategorySearchRepository {
  final CategorySearchDataSource dataSource;

  CategorySearchRepository(this.dataSource);

  Future<List<News>> searchByCategory(String query, String categoryId) async {
    final response = await dataSource.searchNewsByCategory(query, categoryId);

    return response.newsList ?? [];
  }
}
