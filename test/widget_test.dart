import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:newsapp/repository/news_repository.dart';

void main() {
  test('missing key fails before a network call', () async {
    final repository = NewsRepository(
        apiKey: '',
        client: MockClient((_) async {
          fail('Network should not be called');
        }));
    await expectLater(
        repository.fetchCategoriesNewsApi('science'), throwsStateError);
  });
  test('provider errors do not crash JSON parsing', () async {
    final repository = NewsRepository(
        apiKey: 'test-only',
        client: MockClient((_) async => http.Response('unavailable', 429)));
    await expectLater(
        repository.fetchCategoriesNewsApi('science'), throwsException);
  });
  test('successful headlines send an encoded source and decode articles',
      () async {
    final repository = NewsRepository(
        apiKey: 'test-only',
        client: MockClient((request) async {
          expect(request.url.queryParameters['sources'], 'bbc-news');
          return http.Response(
              '{"status":"ok","totalResults":0,"articles":[]}', 200);
        }));
    final result = await repository.FetchNewsChannelHeadLinesApi('bbc-news');
    expect(result.articles, isEmpty);
  });
}
