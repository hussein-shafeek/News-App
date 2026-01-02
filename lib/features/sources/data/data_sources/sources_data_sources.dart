import 'package:news/features/sources/data/models/sources_response/source.dart';

abstract class SourcesDataSources {
  Future<List<Source>> getSources(String categoryId);
}
