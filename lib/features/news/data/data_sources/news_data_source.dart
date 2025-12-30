import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/Shared/network/api_endpoints.dart';
import 'package:news/features/news/data/models/news_response/news_response.dart';

class NewsDataSource {
  Future<NewsResponse> getNews(String sourceId) async {
    Uri uri = Uri.https(ApiConstant.baseURL, ApiConstant.newsEndpoint, {
      'apiKey': ApiConstant.apiKey,
      'sources': sourceId,
    });
    http.Response response = await http.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    return NewsResponse.fromJson(json);
  }
}
