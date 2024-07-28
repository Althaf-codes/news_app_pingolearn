import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/utils/constants/app_constant.dart';
import 'package:news_app/view/home/home_screen.dart';
import 'package:news_app/view/search/search_screen.dart';
import 'package:news_app/view/shorts_view/account_screen.dart';
import 'package:news_app/view_model/news_view_model.dart';
import 'package:news_app/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int _currentIndex = 0;
  bool isFab = false;
  bool isBottom = true;
  List<Widget> _screens = [HomeScreen(), AccountScreen()];
  @override
  void initState() {
    final user = FirebaseAuth.instance.currentUser;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<UserViewModel>(context, listen: false)
          .getUser(uid: user!.uid, context: context);

      // await Provider.of<NewsViewModel>(context, listen: false)
      //     .fecthNews(context);

      // await Provider.of<NewsViewModel>(context, listen: false)
      //     .fecthCategoryNews(context, category: "BUSINESS");
      // Provider.of<NewsViewModel>(context, listen: false)
      //     .fecthCategoryNews(context, category: "ENTERTAINMENT");
      // Provider.of<NewsViewModel>(context, listen: false)
      //     .fecthCategoryNews(context, category: "GENERAL");
      // Provider.of<NewsViewModel>(context, listen: false)
      //     .fecthCategoryNews(context, category: "HEALTH");
      // Provider.of<NewsViewModel>(context, listen: false)
      //     .fecthCategoryNews(context, category: "SCIENCE");
      // Provider.of<NewsViewModel>(context, listen: false)
      //     .fecthCategoryNews(context, category: "SPORTS");
      // Provider.of<NewsViewModel>(context, listen: false)
      //     .fecthCategoryNews(context, category: "TECHNOLOGY");
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isFab ? const SearchScreen() : _screens[_currentIndex],
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppConstant.blueColor,
          shape: CircleBorder(),
          onPressed: () {
            setState(() {
              isFab = true;
            });
          },
          child: Icon(
            Icons.search_outlined,
            color: isFab ? AppConstant.whiteColor : Colors.black,
            size: 22,
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          height: 55,
          color: AppConstant.blueColor,
          shape: const CircularNotchedRectangle(),
          notchMargin: 6,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Spacer(),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isFab = false;
                    _currentIndex = 0;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.home_outlined,
                        color: _currentIndex == 0 && !isFab
                            ? AppConstant.whiteColor
                            : Colors.black,
                        size: 20,
                      ),
                      Text('Home',
                          style: _currentIndex == 0 && !isFab
                              ? AppConstant.descriptionMedium
                                  .copyWith(color: AppConstant.whiteColor)
                              : AppConstant.descriptionRegular
                                  .copyWith(color: Colors.black)
                          // TextStyle(
                          //     color: _currentIndex == 0 && !isFab
                          //         ? AppConstant.whiteColor
                          //         : AppConstant.greyColor,
                          //     fontWeight: FontWeight.w600,
                          // fontSize: 12),
                          )
                    ],
                  ),
                ),
              ),
              const Spacer(),
              const SizedBox(
                width: 20,
              ),
              const SizedBox(
                width: 20,
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isFab = false;
                    _currentIndex = 1;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.account_circle_outlined,
                        color: _currentIndex == 1 && !isFab
                            ? AppConstant.whiteColor
                            : Colors.black,
                        size: 20,
                      ),
                      Text('Account',
                          style: _currentIndex == 1 && !isFab
                              ? AppConstant.descriptionMedium
                                  .copyWith(color: AppConstant.whiteColor)
                              : AppConstant.descriptionRegular
                                  .copyWith(color: Colors.black))
                    ],
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ));
  }
}
