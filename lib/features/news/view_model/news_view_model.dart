import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/Shared/widgets/service_locator.dart';
import 'package:news/features/news/data/models/news_response/news.dart';
import 'package:news/features/news/data/repositories/news_repository.dart';
import 'package:news/features/news/view_model/news_states.dart';

class NewsViewModel extends Cubit<NewsStates> {
  NewsRepository newsRepo = ServiceLocator.newsRepository;
  NewsViewModel() : super(NewsInitial());

  Future<void> getNews(String sourceId) async {
    emit(NewsLoading());
    try {
      List<News> newsList = await newsRepo.getNews(sourceId);
      emit(NewsSuccess(newsList));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }
}
