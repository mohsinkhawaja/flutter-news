import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/models/categories_news_model.dart';
import 'package:newsapp/models/news_channel_headlines_model.dart';

class NewsRepository {

  Future<NewsChannelHeadlinesModel> FetchNewsChannelHeadLinesApi(
      String channelName) async {
    String url = 'https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=8faa01d92b9b43139a29b62302822ff1';
    final response = await http.get(Uri.parse(url));
    print(url);

    if(kDebugMode){
      print(response.body);
    }
    ;
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelHeadlinesModel.fromJson(body);
    }
    throw Exception('Error');
  }

  Future<CatogoriesNewsModel> fetchCategoriesNewsApi(
      String category) async {
    String url = 'https://newsapi.org/v2/everything?q=${category}&apiKey=8faa01d92b9b43139a29b62302822ff1';
    final response = await http.get(Uri.parse(url));
    print(url);

    if(kDebugMode){
      print(response.body);
    }
    ;
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CatogoriesNewsModel.fromJson(body);
    }
    throw Exception('Error');
  }
}