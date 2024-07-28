import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/service/news/news_service.dart';
import 'package:news_app/service/news/news_service_impl.dart';
import 'package:news_app/utils/constants/app_constant.dart';
import 'package:news_app/view/home/components/news_list_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  late ScrollController _scrollController;
  Timer? _debounce;
  List<NewsModel> _newsArticles = [];
  final NewsService _newsService = NewsServiceImpl();

  @override
  void initState() {
    _scrollController = ScrollController();
    _controller.addListener(_onSearchChanged);
    super.initState();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (_controller.text.isNotEmpty) {
        _fetchNews(_controller.text);
      }
    });
  }

  Future<void> _fetchNews(String query) async {
    try {
      List<NewsModel> news = await _newsService.fetchByQuery(query: query);
      setState(() {
        _newsArticles = news;
      });
    } catch (e) {
      print('Error fetching news: $e');
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onSearchChanged);
    _controller.dispose();
    _debounce?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.greyColor,
      appBar: AppBar(
        backgroundColor: AppConstant.blueColor,
        title: Text(
          'News Search',
          style: AppConstant.headlineWhite,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              // height: 40,
              // width: ,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    blurRadius: 10,
                    spreadRadius: 7,
                    offset: Offset(1, 10),
                    color: Colors.grey.withOpacity(0.2))
              ]),
              child: TextFormField(
                style: AppConstant.descriptionMedium
                  ..copyWith(color: AppConstant.blueColor, fontSize: 12),
                cursorColor: AppConstant.blueColor,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    isDense: true,
                    labelText: 'Search', //'Username'
                    labelStyle:
                        AppConstant.descriptionMedium.copyWith(fontSize: 14),
                    hintText: "Eg. trump..", // 'Enter your name',
                    hintStyle: AppConstant.descriptionMedium,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                          color: Colors.red,
                          style: BorderStyle.solid,
                          width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      gapPadding: 10,
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                          color: AppConstant.blueColor,
                          style: BorderStyle.solid,
                          width: 1),
                    ),
                    focusColor: AppConstant.whiteColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                          color: Colors.transparent,
                          style: BorderStyle.solid,
                          width: 5),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search, size: 22),
                      onPressed: () {
                        if (_controller.text.isNotEmpty) {
                          _fetchNews(_controller.text);
                        }
                      },
                    ),
                    fillColor: AppConstant.whiteColor,
                    filled: true),

                controller: _controller,
                // validator: validate,
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextField(
          //     controller: _controller,
          //     decoration: InputDecoration(
          //       labelText: 'Search',
          //       suffixIcon: IconButton(
          //         icon: Icon(Icons.search),
          //         onPressed: () {
          //           if (_controller.text.isNotEmpty) {
          //             _fetchNews(_controller.text);
          //           }
          //         },
          //       ),
          //       border: OutlineInputBorder(),
          //     ),
          //   ),
          // ),

          Expanded(
            child: _newsArticles.isNotEmpty
                ? newsListView(
                    scrollController: _scrollController, allNews: _newsArticles)
                : Center(child: Text('No news found')),
          ),
        ],
      ),
    );
  }
}



/*ListView.builder(
                    itemCount: _newsArticles.length,
                    itemBuilder: (context, index) {
                      final article = _newsArticles[index];
                      return ListTile(
                        leading: article.imageUrl != null
                            ? CachedNetworkImage(
                                imageUrl: article.imageUrl!,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              )
                            : null,
                        title: Text(article.title ?? 'No Title'),
                        subtitle: Text(article.description ?? 'No Description'),
                      );
                    },
                  )*/