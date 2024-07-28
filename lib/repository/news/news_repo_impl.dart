import 'package:news_app/model/news_model.dart';
import 'package:news_app/repository/news/news_repo.dart';
import 'package:news_app/service/news/news_service.dart';
import 'package:news_app/service/news/news_service_impl.dart';

class NewsRepoImpl extends NewsRepo {
  final NewsService _newsService = NewsServiceImpl();
  @override
  Future<List<NewsModel>> fecthHeadlines() async {
    try {
      List<dynamic> res = await _newsService.fecthHeadlines();

      print("the res is ${res.toString()}");

      List<NewsModel> newsModel = res
          .map((ele) => NewsModel.fromMap(ele as Map<String, dynamic>))
          .toList();
      return newsModel;
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<List<NewsModel>> fetchCategoryNews({required String category}) async {
    try {
      List<dynamic> res =
          await _newsService.fetchCategoryNews(category: category);

      // print("the res is ${res.toString()}");

      List<NewsModel> newsModel = res
          .map((ele) => NewsModel.fromMap(ele as Map<String, dynamic>))
          .toList();
      return newsModel;
    } on Exception {
      rethrow;
    }
  }
}
