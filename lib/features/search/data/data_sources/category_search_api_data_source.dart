import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/Shared/network/api_endpoints.dart';
import 'package:news/features/news/data/models/news_response/news_response.dart';
import 'package:news/features/search/data/data_sources/category_search_data_source.dart';
import 'package:news/features/sources/data/data_sources/sources_data_sources.dart';

class CategorySearchApiDataSource implements CategorySearchDataSource {
  final SourcesDataSources sourcesDataSources;

  CategorySearchApiDataSource(this.sourcesDataSources);

  @override
  Future<NewsResponse> searchNewsByCategory(
    String query,
    String categoryId,
  ) async {
    final sources = await sourcesDataSources.getSources(categoryId);

    if (sources.isEmpty) {
      return NewsResponse(status: 'ok', totalResults: 0, newsList: []);
    }

    final sourceIds = sources.map((s) => s.id).whereType<String>().toList();
    final joinedSources = sourceIds.join(',');

    String expandedQuery = query.trim().split(" ").length == 1
        ? "$query OR ${query[0].toUpperCase()}${query.substring(1)}"
        : "$query OR ${query.split(' ').map((w) => w[0].toUpperCase() + w.substring(1)).join(' ')}";

    final uriAr =
        Uri.https(ApiConstant.baseURL, ApiConstant.everythingEndpoint, {
          'apiKey': ApiConstant.apiKey,
          'q': expandedQuery,
          'sources': joinedSources,
          'language': 'ar',
          'sortBy': 'publishedAt',
          'pageSize': '30',
        });

    final uriEn =
        Uri.https(ApiConstant.baseURL, ApiConstant.everythingEndpoint, {
          'apiKey': ApiConstant.apiKey,
          'q': expandedQuery,
          'sources': joinedSources,
          'language': 'en',
          'sortBy': 'publishedAt',
          'pageSize': '30',
        });

    final responseAr = await http.get(uriAr);
    final responseEn = await http.get(uriEn);

    List<dynamic> allArticles = [];

    if (responseAr.statusCode == 200) {
      allArticles.addAll(json.decode(responseAr.body)['articles'] ?? []);
    }

    if (responseEn.statusCode == 200) {
      allArticles.addAll(json.decode(responseEn.body)['articles'] ?? []);
    }

    allArticles = allArticles.where((article) {
      final title = (article['title'] ?? '').toString().toLowerCase();
      final desc = (article['description'] ?? '').toString().toLowerCase();
      return title.contains(query.toLowerCase()) ||
          desc.contains(query.toLowerCase());
    }).toList();

    return NewsResponse.fromJson({
      'status': 'ok',
      'totalResults': allArticles.length,
      'articles': allArticles,
    });
  }
}
