import 'package:news/features/sources/data/data_sources/sources_data_sources.dart';
import 'package:news/features/sources/data/models/sources_response/source.dart';

class SourcesFirebaseDataSource implements SourcesDataSources {
  @override
  Future<List<Source>> getSources(String categoryId) async {
    return [];
  }
}
