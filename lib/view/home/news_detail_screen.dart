import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:news_app/view/home/components/news_list_widget.dart';
import 'package:translator/translator.dart';

import 'package:news_app/model/news_model.dart';
import 'package:news_app/utils/constants/app_constant.dart';
import 'package:news_app/utils/widgets/snackbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailScreen extends StatefulWidget {
  final NewsModel newsModel;
  final List<NewsModel> allnews;
  final String time;
  const NewsDetailScreen({
    super.key,
    required this.newsModel,
    required this.allnews,
    required this.time,
  });

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  late WebViewController controller;

  String newsTitle = "";
  // "All he does is win gold medals: Caeleb Dressel captures 8th gold as anchor of US relay team - The Associated Press";
  String newsDescription = '';

  String originalTitle = "";
  // "All he does is win gold medals: Caeleb Dressel captures 8th gold as anchor of US relay team - The Associated Press";

  String originalDescription = "";
  List<NewsModel> relatedArticles = [];
  late ScrollController _scrollController;
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
    Factory(() => EagerGestureRecognizer())
  };

  final UniqueKey _key = UniqueKey();

  @override
  void initState() {
    _scrollController = ScrollController();

    newsTitle = widget.newsModel.title ?? '--------';
    originalTitle = widget.newsModel.title ?? '--------';

    newsDescription = widget.newsModel.description ?? '--------';
    originalDescription = widget.newsModel.description ?? '--------';
    relatedArticles = widget.allnews
        .where((news) => news.title != widget.newsModel.title)
        .toList();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..loadRequest(Uri.parse(widget.newsModel.articleLink ??
              "https://www.google.com/url?sa=i&url=https%3A%2F%2Fhelp.rockcontent.com%2Fen%2Fhow-to-solve-404-error&psig=AOvVaw3u6BStN1fXpmSI83WWklDT&ust=1722257974125000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCMi38YblyYcDFQAAAAAdAAAAABAE"

          // "https://www.ufc.com/news/main-card-results-highlights-winner-interviews-ufc-304-edwards-vs-muhammad-2"
          // 'http://www.afr.com/world/north-america/trump-has-picked-a-vp-with-views-on-women-worse-than-his-own-20240728-p5jx5e'
          ));
    super.initState();
  }

  @override
  void dispose() {
    controller.clearCache();
    _scrollController.dispose();

    super.dispose();
  }

  // final PlatformWebViewController _controller = PlatformWebViewController(
  //   const PlatformWebViewControllerCreationParams(),
  // )..loadRequest(
  //     LoadRequestParams(
  //       uri: Uri.parse('https://flutter.dev'),
  //     ),
  //   );

  final translationLang = [
    'Tamil',
    'English',
    'Hindi',
    'French',
    'Chinese',
    'Japanese'
  ];
  Map<String, String> translationLangCode = {
    'Tamil': 'ta',
    'English': 'en',
    'Hindi': 'hi',
    'French': 'fr',
    'Chinese': 'zh',
    'Japanese': 'ja'
  };

  Future<void> translate({String langToBeTranslated = 'ta'}) async {
    try {
      if (langToBeTranslated == 'en') {
        setState(() {
          newsTitle = originalTitle;
          newsDescription = originalDescription;
        });
        // return "";
      } else {
        final translator = GoogleTranslator();
        var translatedtitle =
            await translator.translate(originalTitle, to: langToBeTranslated);
        var translatedDesciption = await translator
            .translate(originalDescription, to: langToBeTranslated);

        // print("The translated txt is $translation");
        setState(() {
          newsTitle = translatedtitle.text;
          newsDescription = translatedDesciption.text;
        });
        // return translation.text;
      }
    } on Exception catch (e) {
      // return 'Sorry, error occurred while translation';
      showErrorSnackBar(context, "Error Occurred}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 18,
            backgroundColor: AppConstant.greyColor,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new,
                    color: AppConstant.darkBlueColor)),
          ),
        ),
        surfaceTintColor: Colors.transparent,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: AppConstant.greyColor,
              child: PopupMenuButton(
                icon: Icon(
                  Icons.translate_outlined,
                  color: AppConstant.darkBlueColor,
                  size: 20,
                ),
                itemBuilder: (context) => [
                  ...translationLang.map(buildPopUpItem).toList(),
                ],
                onSelected: (val) async {
                  await translate(
                    langToBeTranslated: translationLangCode[val]!,
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: AppConstant.whiteColor,
                height: constraints.maxHeight * .5 +
                    70, // MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      bottom: 70, // to shift little up
                      left: 0,
                      right: 0,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            color: AppConstant.whiteColor,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: widget.newsModel.imageUrl == null
                                    ? AssetImage(
                                        AppConstant.imageFailed,
                                      )
                                    : NetworkImage(
                                        widget.newsModel.imageUrl!))),
                      ),
                    ),
                    Positioned(
                      top: constraints.maxHeight * .45,
                      height: 110,
                      child: Container(
                        // height: 30,
                        // height: 120,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: Text(
                                  newsTitle.split("-").first,
                                  style: AppConstant.descriptionMedium.copyWith(
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.w700),
                                  maxLines: 3,
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                widget.newsModel.author ?? '-----',
                                style: AppConstant.descriptionBold
                                    .copyWith(decoration: TextDecoration.none),
                              ),
                              Text(
                                widget.time,
                                style: AppConstant.descriptionRegular.copyWith(
                                    fontSize: 10,
                                    decoration: TextDecoration.none),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        top: constraints.maxHeight * .4,
                        right: 80,
                        height: 70,
                        child: CircleAvatar(
                          backgroundColor: AppConstant.greyColor,
                          radius: 18,
                          child: IconButton(
                            icon: const Icon(
                              Icons.bookmark_border,
                              size: 18,
                            ),
                            onPressed: () {},
                          ),
                        )),
                    Positioned(
                        top: constraints.maxHeight * .4,
                        right: 30,
                        height: 70,
                        child: CircleAvatar(
                          backgroundColor: AppConstant.greyColor,
                          radius: 18,
                          child: IconButton(
                            icon: const Icon(
                              Icons.share_outlined,
                              size: 18,
                            ),
                            onPressed: () {},
                          ),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  // height: 1000,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          widget.newsModel.description ??
                              '---------------------------------------------------',
                          // "As a cat-loving, cosmopolitan type myself, I do not want Trump and Vance making intimate decisions for American women or judging us or disparaging us for our lives — all nine of them.",
                          style: AppConstant.descriptionMedium.copyWith(
                            // fontSize: 11,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 70),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                backgroundColor: AppConstant.blueColor),
                            onPressed: () async {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  context: context,
                                  builder: (context) {
                                    return DraggableScrollableSheet(
                                        initialChildSize: 0.95,
                                        builder: (context, scrollcontroller) {
                                          return ListView(
                                            shrinkWrap: true,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Australian Financial Review',
                                                      style: AppConstant
                                                          .descriptionMedium,
                                                    ),
                                                    IconButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        icon:
                                                            Icon(Icons.close)),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                color: Colors.white,
                                                height: 1000,
                                                child: WebViewWidget(
                                                  controller: controller,
                                                  key: _key,
                                                  gestureRecognizers:
                                                      gestureRecognizers,
                                                ),
                                              ),
                                            ],
                                          );
                                        });
                                  });
                            },
                            child: Text(
                              "View Full Article",
                              style: AppConstant.descriptionMedium
                                  .copyWith(color: AppConstant.whiteColor),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Related Articles",
                    style: AppConstant.descriptionBold,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: AppConstant.greyColor,
                child: newsListView(
                    scrollController: _scrollController,
                    allNews: relatedArticles),
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }

  PopupMenuItem buildPopUpItem(String item) {
    return PopupMenuItem(value: item, child: Text(item));
  }
  // style: TextStyle(
  //               color: Colors.black,
  //               fontSize: 16,
  //               fontWeight: FontWeight.w600,
  //               letterSpacing: 1))
}
