import 'package:news/features/news/data/models/news_response/news.dart';

abstract class CategorySearchStates {}

class CategorySearchInitial extends CategorySearchStates {}

class CategorySearchLoading extends CategorySearchStates {}

class CategorySearchSuccess extends CategorySearchStates {
  final List<News> news;

  CategorySearchSuccess(this.news);
}

class CategorySearchError extends CategorySearchStates {
  final String message;

  CategorySearchError(this.message);
}
