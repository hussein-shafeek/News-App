import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/core/models/news_response/news_response.dart';
import 'package:news/core/models/sources_response/sources_response.dart';
import 'package:news/core/services/api/api_constant.dart';

class ApiService {
  static Future<SourcesResponse> getSources(String categoryId) async {
    Uri uri = Uri.https(ApiConstant.baseURL, ApiConstant.sourcesEndpoint, {
      'apiKey': ApiConstant.apiKey,
      'category': categoryId,
    });
    http.Response response = await http.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    return SourcesResponse.fromJson(json);
  }

  static Future<NewsResponse> getNews(String sourceId) async {
    Uri uri = Uri.https(ApiConstant.baseURL, ApiConstant.newsEndpoint, {
      'apiKey': ApiConstant.apiKey,
      'sources': sourceId,
    });
    http.Response response = await http.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    return NewsResponse.fromJson(json);
  }

  static Future<NewsResponse> searchNews(String query) async {
    final uri = Uri.https(ApiConstant.baseURL, ApiConstant.everythingEndpoint, {
      'apiKey': ApiConstant.apiKey,
      'q': query,
      'sortBy': 'publishedAt',
      'pageSize': '30',
    });
    final response = await http.get(uri);
    final Map<String, dynamic> json = jsonDecode(response.body);
    return NewsResponse.fromJson(json);
  }
}
