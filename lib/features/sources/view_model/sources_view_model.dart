import 'package:news/Shared/widgets/service_locator.dart';
import '../data/repositories/sources_repository.dart';
import '../data/models/sources_response/source.dart';
import '../view_model/sources_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SourcesViewModel extends Cubit<SourcesStates> {
  SourcesViewModel() : super(SourcesInitial());

  SourcesRepository repo = ServiceLocator.sourcesRepository;
  Future<void> getSources(String categoryId) async {
    emit(SourcesLoading());

    try {
      List<Source> sources = await repo.getSources(categoryId);
      emit(SourcesSuccess(sources));
    } catch (e) {
      emit(SourcesError(e.toString()));
    }
  }
}
