import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/news_article_model.dart';

class NewsService {
  static final NewsService _instance = NewsService._internal();

  factory NewsService() => _instance;

  NewsService._internal();

  final http.Client _client = http.Client();

  final String _baseUrl = 'https://newsapi.org/v2';

  Future<List<NewsArticle>> fetchNews() async {
    final String? apiKey = dotenv.env['NEWS_API_KEY'];

    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('API Key is missing. Please check your .env file.');
    }

    final Uri url = Uri.parse(
        '$_baseUrl/everything?q=tesla&from=2025-01-20&sortBy=publishedAt&apiKey=$apiKey');

    try {
      final response =
          await _client.get(url).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return parseArticles(response.body);
      } else {
        throw HttpException(
            'Error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } on SocketException {
      throw Exception('No Internet connection.');
    } on HttpException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  List<NewsArticle> parseArticles(String responseBody) {
    final Map<String, dynamic> parsed = json.decode(responseBody);

    if (parsed.containsKey('articles') && parsed['articles'] is List) {
      return (parsed['articles'] as List)
          .map((json) => NewsArticle.fromJson(json))
          .toList();
    }

    return [];
  }
}
