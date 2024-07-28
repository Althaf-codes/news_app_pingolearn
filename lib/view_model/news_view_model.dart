import 'package:flutter/material.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/repository/news/news_repo.dart';
import 'package:news_app/repository/news/news_repo_impl.dart';
import 'package:news_app/utils/widgets/snackbar.dart';

class NewsViewModel extends ChangeNotifier {
  List<NewsModel> _allNews = [];
  List<NewsModel> get allNews => _allNews;

  List<NewsModel> _businessNews = [];
  List<NewsModel> get businessNews => _businessNews;

  List<NewsModel> _healthNews = [];
  List<NewsModel> get healthNews => _healthNews;

  List<NewsModel> _generalNews = [];
  List<NewsModel> get generalNews => _generalNews;

  List<NewsModel> _entertainmentNews = [];
  List<NewsModel> get entertainmentNews => _entertainmentNews;

  List<NewsModel> _scienceNews = [];
  List<NewsModel> get scienceNews => _scienceNews;

  List<NewsModel> _sportsNews = [];
  List<NewsModel> get sportsNews => _sportsNews;

  List<NewsModel> _technologyNews = [];
  List<NewsModel> get technologyNews => _technologyNews;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  NewsRepo _newsRepo = NewsRepoImpl();

  Future<void> fecthNews(BuildContext context) async {
    try {
      List<NewsModel> news = await _newsRepo.fecthHeadlines();

      _allNews = news;

      // print("the news is ${news.toString()}");
      // print("the news length is ${news.length}");

      notifyListeners();
    } catch (e) {
      if (context.mounted) {
        print("The Error is ${e.toString()}");
        showSnackBar(context, e.toString());
      }
    }
  }

  void setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  Future<void> fecthCategoryNews(BuildContext context,
      {required String category}) async {
    try {
      setLoading(true);
      List<NewsModel> news =
          await _newsRepo.fetchCategoryNews(category: category.toLowerCase());

      if (category == "BUSINESS") {
        _businessNews = news;
      } else if (category == "ENTERTAINMENT") {
        _entertainmentNews = news;
      } else if (category == "GENERAL") {
        _generalNews = news;
      } else if (category == "HEALTH") {
        _healthNews = news;
      } else if (category == "SCIENCE") {
        _scienceNews = news;
      } else if (category == "SPORTS") {
        _sportsNews = news;
      } else if (category == "TECHNOLOGY") {
        _technologyNews = news;
      }

      // print("the news is ${news.toString()}");
      // print("the news length is ${news.length}");
      setLoading(false);
      // notifyListeners();
    } catch (e) {
      if (context.mounted) {
        print("The Error is ${e.toString()}");
        showSnackBar(context, e.toString());
      }
    }
  }
}
