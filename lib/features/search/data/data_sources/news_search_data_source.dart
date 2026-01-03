import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/Shared/network/api_endpoints.dart';
import 'package:news/features/news/data/models/news_response/news_response.dart';

Future<NewsResponse> searchNews(String query) async {
  final uriAr = Uri.https(ApiConstant.baseURL, ApiConstant.everythingEndpoint, {
    'apiKey': ApiConstant.apiKey,
    'q': query,
    'language': 'ar',
    'sortBy': 'publishedAt',
    'pageSize': '30',
  });

  final uriEn = Uri.https(ApiConstant.baseURL, ApiConstant.everythingEndpoint, {
    'apiKey': ApiConstant.apiKey,
    'q': query,
    'language': 'en',
    'sortBy': 'publishedAt',
    'pageSize': '30',
  });

  final responseAr = await http.get(uriAr);
  final responseEn = await http.get(uriEn);

  List<dynamic> allArticles = [];

  if (responseAr.statusCode == 200) {
    final Map<String, dynamic> dataAr = json.decode(responseAr.body);
    allArticles.addAll(dataAr['articles']);
  }

  if (responseEn.statusCode == 200) {
    final Map<String, dynamic> dataEn = json.decode(responseEn.body);
    allArticles.addAll(dataEn['articles']);
  }

  return NewsResponse.fromJson({
    'status': 'ok',
    'totalResults': allArticles.length,
    'articles': allArticles,
  });
}
