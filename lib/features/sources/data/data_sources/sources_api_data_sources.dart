import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/Shared/network/api_endpoints.dart';
import 'package:news/features/sources/data/data_sources/sources_data_sources.dart';
import 'package:news/features/sources/data/models/sources_response/source.dart';
import 'package:news/features/sources/data/models/sources_response/sources_response.dart';

class SourcesApiDataSources implements SourcesDataSources {
  @override
  Future<List<Source>> getSources(String categoryId) async {
    Uri uri = Uri.https(ApiConstant.baseURL, ApiConstant.sourcesEndpoint, {
      'apiKey': ApiConstant.apiKey,
      'category': categoryId,
    });
    http.Response response = await http.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    SourcesResponse sourcesResponse = SourcesResponse.fromJson(json);
    if (sourcesResponse.status == 'ok' && sourcesResponse.sources != null) {
      return sourcesResponse.sources!;
    } else {
      throw Exception('Failed to get sources');
    }
  }
}
