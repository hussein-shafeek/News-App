import 'package:flutter/material.dart';
import 'package:news/Shared/widgets/service_locator.dart';
import '../data/repositories/sources_repository.dart';
import '../data/models/sources_response/source.dart';

class SourcesViewModel with ChangeNotifier {
  SourcesRepository repo = ServiceLocator.sourcesRepository;
  List<Source> sources = [];
  String? errorMessage;
  bool isLoading = false;
  Future<void> getSources(String categoryId) async {
    isLoading = true;
    notifyListeners();

    try {
      sources = await repo.getSources(categoryId);
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
