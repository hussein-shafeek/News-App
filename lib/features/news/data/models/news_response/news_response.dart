import 'package:news/features/news/data/models/news_response/news.dart';

class NewsResponse {
  String? status;
  int? totalResults;
  List<News>? newsList;

  NewsResponse({this.status, this.totalResults, this.newsList});

  factory NewsResponse.fromJson(Map<String, dynamic> json) => NewsResponse(
    status: json['status'] as String?,
    totalResults: json['totalResults'] as int?,
    newsList: (json['articles'] as List<dynamic>?)
        ?.map((e) => News.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}
