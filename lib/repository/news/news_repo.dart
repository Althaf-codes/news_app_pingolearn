import 'package:news_app/model/news_model.dart';

abstract class NewsRepo {
  Future<List<NewsModel>> fecthHeadlines();
  Future<List<NewsModel>> fetchCategoryNews({required String category});
}
