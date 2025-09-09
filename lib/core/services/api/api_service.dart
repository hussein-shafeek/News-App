// في ملف lib/core/services/api/api_service.dart

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

  // الدالة للبحث عن أخبار في فئة معينة
  static Future<NewsResponse> searchNewsByCategory(
    String query,
    String category,
  ) async {
    // هات المصادر الخاصة بالكاتيجوري
    final sourcesResponse = await getSources(category);
    final sources = sourcesResponse.sources ?? [];
    if (sources.isEmpty) {
      return NewsResponse(status: 'ok', totalResults: 0, newsList: []);
    }

    final sourceIds = sources.map((s) => s.id).whereType<String>().toList();
    final joinedSources = sourceIds.join(',');

    //  Dynamic query: نوسع الكلمة
    String expandedQuery = query;
    if (query.trim().split(" ").length == 1) {
      // كلمة واحدة → جرب OR
      expandedQuery =
          "$query OR ${query[0].toUpperCase()}${query.substring(1)}";
    } else {
      // أكتر من كلمة → ابعتها زي ما هي + OR نسخة Title Case
      expandedQuery =
          "$query OR ${query.split(' ').map((w) => w[0].toUpperCase() + w.substring(1)).join(' ')}";
    }

    //  عربي
    final uriAr =
        Uri.https(ApiConstant.baseURL, ApiConstant.everythingEndpoint, {
          'apiKey': ApiConstant.apiKey,
          'q': expandedQuery,
          'sources': joinedSources,
          'language': 'ar',
          'sortBy': 'publishedAt',
          'pageSize': '30',
        });

    //  إنجليزي
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

    //  معالجة العربي مع fallback
    if (responseAr.statusCode == 200) {
      final Map<String, dynamic> dataAr = json.decode(responseAr.body);
      if (dataAr['articles'] != null && dataAr['articles'].isNotEmpty) {
        allArticles.addAll(dataAr['articles']);
      } else {
        // 🔥 fallback: هات أخبار بالعربي من غير sources
        final fallbackUriAr =
            Uri.https(ApiConstant.baseURL, ApiConstant.everythingEndpoint, {
              'apiKey': ApiConstant.apiKey,
              'q': expandedQuery,
              'language': 'ar',
              'sortBy': 'publishedAt',
              'pageSize': '30',
            });
        final fallbackRes = await http.get(fallbackUriAr);
        if (fallbackRes.statusCode == 200) {
          final Map<String, dynamic> fbDataAr = json.decode(fallbackRes.body);
          allArticles.addAll(fbDataAr['articles']);
        }
      }
    }

    //  معالجة الإنجليزي
    if (responseEn.statusCode == 200) {
      final Map<String, dynamic> dataEn = json.decode(responseEn.body);
      allArticles.addAll(dataEn['articles']);
    }

    // فلترة Dynamic: نتأكد المقال فيه الكلمة
    allArticles = allArticles.where((article) {
      final title = (article['title'] ?? "").toString().toLowerCase();
      final desc = (article['description'] ?? "").toString().toLowerCase();
      return title.contains(query.toLowerCase()) ||
          desc.contains(query.toLowerCase());
    }).toList();

    return NewsResponse.fromJson({
      'status': 'ok',
      'totalResults': allArticles.length,
      'articles': allArticles,
    });
  }

  // **تمت إضافة هذه الدالة للبحث العام عن الأخبار**
  static Future<NewsResponse> searchNews(String query) async {
    final uriAr =
        Uri.https(ApiConstant.baseURL, ApiConstant.everythingEndpoint, {
          'apiKey': ApiConstant.apiKey,
          'q': query,
          'language': 'ar',
          'sortBy': 'publishedAt',
          'pageSize': '30',
        });

    final uriEn =
        Uri.https(ApiConstant.baseURL, ApiConstant.everythingEndpoint, {
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
}
