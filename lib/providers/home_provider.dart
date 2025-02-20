import 'package:flutter/material.dart';

import '../methods/home_methods.dart';
import '../models/news_article_model.dart';

class HomeProvider extends ChangeNotifier {
  final NewsService _newsService = NewsService();

  List<NewsArticle> _articles = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<NewsArticle> get articles => _articles;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  Future<void> fetchNews() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners(); // Notify UI about state change

    try {
      _articles = await _newsService.fetchNews();
    } catch (e) {
      print("error is ${e.toString()}");
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify UI about state change
    }
  }

  void updateLikeStatus(int index) {
    NewsArticle article = articles[index];
    article.isLiked =!article.isLiked;
    notifyListeners();

  }

  void setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
