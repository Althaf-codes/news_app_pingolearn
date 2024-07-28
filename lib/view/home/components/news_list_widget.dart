import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/utils/constants/app_constant.dart';
import 'package:news_app/view/home/news_detail_screen.dart';

Widget newsListView(
    {required ScrollController scrollController,
    required List<NewsModel> allNews}) {
  return ListView.builder(
      shrinkWrap: true,
      itemCount: allNews.length, // allnews.length,
      controller: scrollController,
      itemBuilder: (context, index) {
        NewsModel newsModel = allNews[index];
        String time = AppConstant.timeAgo(newsModel.publishedAt);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewsDetailScreen(
                            newsModel: newsModel,
                            time: time,
                            allnews: allNews,
                          )));
            },
            child: Container(
              height: 120,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  color: AppConstant.whiteColor,
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              newsModel.source?.name ??
                                  "News Source", //'News Source',
                              style: AppConstant.headlineBlack
                                  .copyWith(fontSize: 13),
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Expanded(
                            child: Text(
                              newsModel.title ?? '------',
                              //'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque tellus leo, tincidunt condimentum nisi ac, sagittis malesuada eros. Nullam vitae purus imperdiet, vulputate diam quis, lacinia nulla. Ut sit amet maximus nisi. Duis luctus interdum erat in pretium. Cras placerat orci et sapien commodo tempus. Donec at dui venenatis,',
                              style: AppConstant.descriptionMedium
                                  .copyWith(fontSize: 11),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              time, //'10 min ago',
                              style: AppConstant.descriptionRegular
                                  .copyWith(fontSize: 9),
                            ),
                          ),
                        ],
                      ),
                    )),
                    Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: const BoxDecoration(
                        color: AppConstant.whiteColor,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        // image: DecorationImage(
                        //     fit: BoxFit.cover,
                        //     image: newsModel.imageUrl == null
                        //         ? AssetImage(AppConstant.imageLoadedFailed)
                        //         : NetworkImage(newsModel.imageUrl!)),
                      ),
                      child: newsModel.imageUrl == null
                          ? Image.asset(
                              AppConstant.imageFailed,
                              height: 100,
                              width: MediaQuery.of(context).size.width * 0.3,
                            )
                          : CachedNetworkImage(
                              imageUrl: newsModel.imageUrl!,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator.adaptive(
                                    backgroundColor: AppConstant.darkBlueColor,
                                  ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                      decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                        colorFilter: const ColorFilter.mode(
                                            AppConstant.blueColor,
                                            BlendMode.colorBurn)),
                                  ))),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
        // });
      });
}
