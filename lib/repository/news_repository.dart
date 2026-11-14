import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/categories_news_model.dart';
import '../models/news_channel_headlines_model.dart';

class NewsRepository {
  final http.Client _client;
  final String _apiKey;
  NewsRepository({http.Client? client, String? apiKey})
      : _client = client ?? http.Client(),
        _apiKey = apiKey ?? const String.fromEnvironment('NEWS_API_KEY');

  Future<Map<String, dynamic>> _get(
      String endpoint, Map<String, String> parameters) async {
    if (_apiKey.trim().isEmpty)
      throw StateError('Configure NEWS_API_KEY with your own development key.');
    final uri = Uri.https(
        'newsapi.org', '/v2/$endpoint', {...parameters, 'apiKey': _apiKey});
    final response =
        await _client.get(uri).timeout(const Duration(seconds: 20));
    if (response.statusCode != 200)
      throw Exception(
          'News service returned HTTP ${response.statusCode}. Check your key and plan limits.');
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    if (body['status'] != 'ok')
      throw Exception('The news provider could not serve this request.');
    return body;
  }

  Future<NewsChannelHeadlinesModel> FetchNewsChannelHeadLinesApi(
          String channelName) async =>
      NewsChannelHeadlinesModel.fromJson(
          await _get('top-headlines', {'sources': channelName}));
  Future<CatogoriesNewsModel> fetchCategoriesNewsApi(String category) async =>
      CatogoriesNewsModel.fromJson(await _get('everything', {'q': category}));
}
