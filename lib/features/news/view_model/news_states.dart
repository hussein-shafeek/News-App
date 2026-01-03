import 'package:equatable/equatable.dart';
import 'package:news/features/news/data/models/news_response/news.dart';

sealed class NewsStates extends Equatable {
  const NewsStates();
  @override
  List<Object?> get props => [];
}

class NewsInitial extends NewsStates {
  @override
  List<Object?> get props => [];
}

class NewsLoading extends NewsStates {
  @override
  List<Object?> get props => [];
}

class NewsSuccess extends NewsStates {
  final List<News> newsList;
  const NewsSuccess(this.newsList);
  @override
  List<Object?> get props => [newsList];
}

class NewsError extends NewsStates {
  final String message;
  const NewsError(this.message);
  @override
  List<Object?> get props => [message];
}
