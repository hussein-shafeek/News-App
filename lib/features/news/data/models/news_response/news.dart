import 'package:news/features/sources/data/models/sources_response/source.dart';

class News {
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  DateTime? publishedAt;
  String? content;

  News({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
    source: json['source'] == null
        ? null
        : Source.fromJson(json['source'] as Map<String, dynamic>),
    author: json['author'] as String?,
    title: json['title'] as String?,
    description: json['description'] as String?,
    url: json['url'] as String?,
    urlToImage: json['urlToImage'] as String?,
    publishedAt: json['publishedAt'] == null
        ? null
        : DateTime.parse(json['publishedAt']),
    content: json['content'] as String?,
  );
}
