import 'package:news/Shared/services/api/api_service.dart';
import 'package:news/features/news/data/models/news_response/news.dart';

class SearchRemoteDataSource {
  Future<List<News>> search(String query) async {
    final response = await ApiService.searchNews(query);
    return response.newsList ?? [];
  }
}
