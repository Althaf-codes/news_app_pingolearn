import 'package:flutter/material.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/utils/constants/app_constant.dart';
import 'package:news_app/view/home/components/news_list_widget.dart';
import 'package:news_app/view/home/news_detail_screen.dart';
import 'package:news_app/view_model/news_view_model.dart';
import 'package:provider/provider.dart';

class SportsNewsScreen extends StatefulWidget {
  const SportsNewsScreen({super.key});

  @override
  State<SportsNewsScreen> createState() => _SportsNewsScreenState();
}

class _SportsNewsScreenState extends State<SportsNewsScreen>
    with AutomaticKeepAliveClientMixin {
  late ScrollController _scrollController1;
  late ScrollController _scrollController2;

  @override
  void initState() {
    _scrollController1 = ScrollController();
    _scrollController2 = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController1.dispose();
    _scrollController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        Provider.of<NewsViewModel>(context, listen: false)
            .fecthCategoryNews(context, category: "SPORTS");
      },
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Sports Headlines',
              style: AppConstant.headlineBlack.copyWith(fontSize: 14),
            ),
          ),
          Consumer<NewsViewModel>(builder: (context, value, child) {
            if (value.isLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: AppConstant.blueColor,
                ),
              );
            }
            return newsListView(
                scrollController: _scrollController2,
                allNews: value.sportsNews);
          }),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
