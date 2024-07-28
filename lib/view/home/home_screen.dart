import 'package:flutter/material.dart';
import 'package:news_app/service/config/remote_config.dart';
import 'package:news_app/utils/constants/app_constant.dart';
import 'package:news_app/view/home/news_detail_screen.dart';
import 'package:news_app/view/home/tabs/all_news_screen.dart';
import 'package:news_app/view/home/tabs/business_news_screen.dart';
import 'package:news_app/view/home/tabs/entertainment_news_screen.dart';
import 'package:news_app/view/home/tabs/general_news_screen.dart';
import 'package:news_app/view/home/tabs/health_news_screen.dart';
import 'package:news_app/view/home/tabs/science_news_screen.dart';
import 'package:news_app/view/home/tabs/sports_news_screen.dart';
import 'package:news_app/view/home/tabs/tech_news_screen.dart';
import 'package:news_app/view_model/news_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController1;
  late ScrollController _scrollController2;
  // String country = "";
  RemoteConfigService _remoteConfigService = RemoteConfigService();
  int _currentIndex = 0;

  @override
  void initState() {
    _scrollController1 = ScrollController();
    _scrollController2 = ScrollController();
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    await Provider.of<NewsViewModel>(context, listen: false).fecthNews(context);
    await Provider.of<NewsViewModel>(context, listen: false)
        .fecthCategoryNews(context, category: "BUSINESS");
    Provider.of<NewsViewModel>(context, listen: false)
        .fecthCategoryNews(context, category: "ENTERTAINMENT");
    Provider.of<NewsViewModel>(context, listen: false)
        .fecthCategoryNews(context, category: "GENERAL");
    Provider.of<NewsViewModel>(context, listen: false)
        .fecthCategoryNews(context, category: "HEALTH");
    Provider.of<NewsViewModel>(context, listen: false)
        .fecthCategoryNews(context, category: "SCIENCE");
    Provider.of<NewsViewModel>(context, listen: false)
        .fecthCategoryNews(context, category: "SPORTS");
    Provider.of<NewsViewModel>(context, listen: false)
        .fecthCategoryNews(context, category: "TECHNOLOGY");
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _scrollController1.dispose();
    _scrollController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConstant.greyColor,
        // appBar: AppBar(
        //   backgroundColor: AppConstant.blueColor,
        //   title: Text(
        //     'MyNews',
        //     style: AppConstant.headlineWhite,
        //   ),
        //   actions: [
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: GestureDetector(
        //         onTap: () {
        //           Provider.of<NewsViewModel>(context, listen: false)
        //               .fecthNews(context);
        //         },
        //         child: Row(
        //           children: [
        //             Icon(Icons.send),
        //             Text(
        //               _remoteConfigService.country.toUpperCase(),
        //               style: AppConstant.headlineWhite,
        //             ),
        //           ],
        //         ),
        //       ),
        //     )
        //   ],
        // ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
                pinned: true,
                expandedHeight: 100,
                backgroundColor: AppConstant.blueColor,
                title: Text(
                  'MyNews',
                  style: AppConstant.headlineWhite,
                ),
                elevation: 40,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Provider.of<NewsViewModel>(context, listen: false)
                            .fecthNews(context);
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.location_pin,
                              color: AppConstant.whiteColor, size: 18),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            _remoteConfigService.country.toUpperCase(),
                            style: AppConstant.headlineWhite,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
                bottom: PreferredSize(
                    preferredSize: Size(MediaQuery.of(context).size.width, 20),
                    child: _buildTabBar())),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                controller: _scrollController1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      // _buildTabBar(),
                      const SizedBox(
                        height: 10,
                      ),
                      _buildTabContent(),

                      //  Consumer<NewsViewModel>(builder: (context, value, child) {
                      //     return ListView.builder(
                      //         shrinkWrap: true,
                      //         itemCount: value.allNews.length, // allnews.length,
                      //         controller: _scrollController2,
                      //         itemBuilder: (context, index) {
                      //           return Padding(
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: GestureDetector(
                      //               onTap: () {
                      //                 Navigator.push(
                      //                     context,
                      //                     MaterialPageRoute(
                      //                         builder: (context) =>
                      //                             NewsDetailScreen()));
                      //               },
                      //               child: Container(
                      //                 height: 120,
                      //                 width: MediaQuery.of(context).size.width * 0.9,
                      //                 decoration: BoxDecoration(
                      //                     color: AppConstant.whiteColor,
                      //                     borderRadius: BorderRadius.circular(12)),
                      //                 child: Padding(
                      //                   padding: const EdgeInsets.all(8.0),
                      //                   child: Row(
                      //                     mainAxisAlignment:
                      //                         MainAxisAlignment.spaceAround,
                      //                     children: [
                      //                       Expanded(
                      //                           child: Padding(
                      //                         padding: const EdgeInsets.all(8.0),
                      //                         child: Column(
                      //                           children: [
                      //                             Align(
                      //                               alignment: Alignment.topLeft,
                      //                               child: Text(
                      //                                 'News Source',
                      //                                 style: AppConstant.headlineBlack
                      //                                     .copyWith(fontSize: 13),
                      //                               ),
                      //                             ),
                      //                             const SizedBox(
                      //                               height: 2,
                      //                             ),
                      //                             Expanded(
                      //                               child: Text(
                      //                                 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque tellus leo, tincidunt condimentum nisi ac, sagittis malesuada eros. Nullam vitae purus imperdiet, vulputate diam quis, lacinia nulla. Ut sit amet maximus nisi. Duis luctus interdum erat in pretium. Cras placerat orci et sapien commodo tempus. Donec at dui venenatis,',
                      //                                 style: AppConstant
                      //                                     .descriptionMedium
                      //                                     .copyWith(fontSize: 11),
                      //                                 maxLines: 3,
                      //                                 overflow: TextOverflow.ellipsis,
                      //                               ),
                      //                             ),
                      //                             Align(
                      //                               alignment: Alignment.centerLeft,
                      //                               child: Text(
                      //                                 '10 min ago',
                      //                                 style: AppConstant
                      //                                     .descriptionRegular
                      //                                     .copyWith(fontSize: 9),
                      //                               ),
                      //                             ),
                      //                           ],
                      //                         ),
                      //                       )),
                      //                       Container(
                      //                         height: 100,
                      //                         width: MediaQuery.of(context).size.width *
                      //                             0.3,
                      //                         decoration: const BoxDecoration(
                      //                             color: AppConstant.blueColor,
                      //                             borderRadius: BorderRadius.all(
                      //                                 Radius.circular(12))),
                      //                       )
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           );
                      //           // });
                      //         });
                      //   })
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget _buildTabBar() {
    return Container(
      height: 40,
      child: ListView(
        // controller: _scrollController2,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [
          // _buildTabItem(0, Icons.abc, "All"),
          // _buildTabItem(1, Icons.attach_money, 'Business'),
          // _buildTabItem(2, Icons.music_note, 'Entertainment'),
          // _buildTabItem(3, Icons.devices, 'Technology'),
          // _buildTabItem(4, Icons.health_and_safety, 'Health'),
          // _buildTabItem(5, Icons.science, 'Science'),
          // _buildTabItem(6, Icons.sports_score, 'Sports'),
          // _buildTabItem(7, Icons.info, 'General'),

          _buildTabItem2(0, "All"),
          _buildTabItem2(1, 'Business'),
          _buildTabItem2(2, 'Entertainment'),
          _buildTabItem2(3, 'Technology'),
          _buildTabItem2(4, 'Health'),
          _buildTabItem2(5, 'Science'),
          _buildTabItem2(6, 'Sports'),
          _buildTabItem2(7, 'General'),
        ],
      ),
    );
  }

  Widget _buildTabItem(int index, IconData icon, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: _currentIndex == index
                    ? AppConstant.blueColor
                    : Colors.white,
              ),
              child: index == 0
                  ? Container()
                  : Icon(
                      icon,
                      size: 20,
                      color:
                          _currentIndex == index ? Colors.white : Colors.black,
                    ),
            ),
            Text(
              label,
              style: const TextStyle(color: Colors.black, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem2(int index, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: _currentIndex == index ? Colors.black : AppConstant.whiteColor,
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            style: AppConstant.descriptionMedium.copyWith(
              color: _currentIndex == index
                  ? AppConstant.whiteColor
                  : AppConstant.darkBlueColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    return IndexedStack(
      index: _currentIndex,
      children: const [
        AllNewsScreen(),
        BusinessNewsScreen(),
        EntertainmentNewsScreen(),
        TechNewsScreen(),
        HealthNewsScreen(),
        ScienceNewsScreen(),
        SportsNewsScreen(),
        GeneralNewsScreen()
      ],
    );
  }

  Widget _buildTabContentItem(String content) {
    return Center(
      child: Text(
        content,
        style: const TextStyle(fontSize: 20.0),
      ),
    );
  }
}
