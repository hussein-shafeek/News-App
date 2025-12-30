import 'package:flutter/material.dart';
import 'package:news/features/sources/data/data_sources/sources_data_sources.dart';
import 'package:news/features/sources/data/models/sources_response/sources_response.dart';

import '../data/models/sources_response/source.dart';

class SourcesViewModel with ChangeNotifier {
  SourcesDataSources dataSources = SourcesDataSources();
  List<Source> sources = [];
  String? errorMessage = '';
  bool isLoading = false;
  Future<void> getSources(String categoryId) async {
    isLoading = true;

    try {
      SourcesResponse response = await dataSources.getSources(categoryId);
      if (response.status == 'ok' && response.sources != null) {
        sources = response.sources!;
      } else {
        errorMessage = 'Failed to get sources';
      }
    } catch (e) {
      errorMessage = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
