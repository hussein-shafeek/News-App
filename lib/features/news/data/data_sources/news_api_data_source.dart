import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/Shared/network/api_endpoints.dart';
import 'package:news/features/news/data/data_sources/news_data_source.dart';
import 'package:news/features/news/data/models/news_response/news.dart';
import 'package:news/features/news/data/models/news_response/news_response.dart';

class NewsApiDataSource implements NewsDataSource {
  @override
  Future<List<News>> getNews(String sourceId) async {
    Uri uri = Uri.https(ApiConstant.baseURL, ApiConstant.newsEndpoint, {
      'apiKey': ApiConstant.apiKey,
      'sources': sourceId,
    });
    http.Response response = await http.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    NewsResponse newsResponse = NewsResponse.fromJson(json);
    if (newsResponse.status == 'ok' && newsResponse.newsList != null) {
      return newsResponse.newsList!;
    } else {
      throw Exception('Failed to get news');
    }
  }
}
