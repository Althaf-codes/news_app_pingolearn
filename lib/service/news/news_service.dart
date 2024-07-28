import 'package:news_app/model/news_model.dart';

abstract class NewsService {
  Future<List<dynamic>> fecthHeadlines();
  Future<List<dynamic>> fetchCategoryNews({required String category});
  Future<List<NewsModel>> fetchByQuery({required String query});
}
