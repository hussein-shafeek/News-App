import 'package:news/features/news/data/data_sources/news_api_data_source.dart';
import 'package:news/features/news/data/data_sources/news_data_source.dart';
import 'package:news/features/news/data/repositories/news_repository.dart';
import 'package:news/features/sources/data/data_sources/sources_api_data_sources.dart';
import 'package:news/features/sources/data/data_sources/sources_data_sources.dart';
import 'package:news/features/sources/data/repositories/sources_repository.dart';

class ServiceLocator {
  static NewsDataSource newsDataSource = NewsApiDataSource();
  static SourcesDataSources sourcesDataSource = SourcesApiDataSources();
  static SourcesRepository sourcesRepository = SourcesRepository(
    sourcesDataSource,
  );
  static NewsRepository newsRepository = NewsRepository(newsDataSource);
}
