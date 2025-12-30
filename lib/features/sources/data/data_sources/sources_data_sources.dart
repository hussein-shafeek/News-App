import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/Shared/network/api_endpoints.dart';
import 'package:news/features/sources/data/models/sources_response/sources_response.dart';

class SourcesDataSources {
  Future<SourcesResponse> getSources(String categoryId) async {
    Uri uri = Uri.https(ApiConstant.baseURL, ApiConstant.sourcesEndpoint, {
      'apiKey': ApiConstant.apiKey,
      'category': categoryId,
    });
    http.Response response = await http.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    return SourcesResponse.fromJson(json);
  }
}
