import 'package:news/features/sources/data/data_sources/sources_api_data_sources.dart';
import 'package:news/features/sources/data/data_sources/sources_data_sources.dart';
import 'package:news/features/sources/data/models/sources_response/source.dart';

class SourcesRepository {
  SourcesDataSources dataSources;
  SourcesRepository(this.dataSources);
  Future<List<Source>> getSources(String categoryId) {
    return dataSources.getSources(categoryId);
  }
}
