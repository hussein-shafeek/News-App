import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/features/search/view_model/category_search_states.dart';
import 'package:news/features/search/data/repositories/category_search_repository.dart';

class CategorySearchCubit extends Cubit<CategorySearchStates> {
  final CategorySearchRepository repository;

  CategorySearchCubit(this.repository) : super(CategorySearchInitial());

  Future<void> search(String query, String categoryId) async {
    if (query.trim().isEmpty) return;

    emit(CategorySearchLoading());

    try {
      final news = await repository.searchByCategory(query, categoryId);
      emit(CategorySearchSuccess(news));
    } catch (e) {
      emit(CategorySearchError(e.toString()));
    }
  }
}
