import 'package:news/features/news/data/models/news_response/news_response.dart';

abstract class CategorySearchDataSource {
  Future<NewsResponse> searchNewsByCategory(String query, String categoryId);
}
