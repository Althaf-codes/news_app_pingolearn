import 'package:flutter/material.dart';
import 'package:news_app/utils/constants/app_constant.dart';
import 'package:news_app/utils/widgets/setting_card.dart';
import 'package:news_app/view_model/auth_view_model.dart';
import 'package:news_app/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Text(
                      'Your Profile',
                      style: TextStyle(
                          color: Colors.indigo[900],
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Consumer<UserViewModel>(
                                  builder: (context, value, child) {
                                return CircleAvatar(
                                  backgroundColor: AppConstant.blueColor,
                                  radius: 70,
                                  child: Text(value.user.name.characters.first,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold)),
                                );
                              }),
                              Positioned(
                                bottom: 1,
                                right: -10,
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.indigo[900]),
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.add_a_photo_outlined,
                                        size: 25,
                                        color: Colors.white,
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        SettingCard(
                            icon: Icons.person_outline, text: 'Account'),
                        const Divider(),
                        const SizedBox(
                          height: 10,
                        ),
                        SettingCard(
                            icon: Icons.lock_outline,
                            text: 'Privacy & Security'),
                        const Divider(),
                        const SizedBox(
                          height: 10,
                        ),
                        SettingCard(
                            icon: Icons.headphones, text: 'Help and Support'),
                        const Divider(),
                        const SizedBox(
                          height: 10,
                        ),
                        SettingCard(
                            icon: Icons.question_mark_sharp, text: 'About'),
                        const Divider(),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await Provider.of<AuthViewModel>(context,
                                    listen: false)
                                .signOut();
                          },
                          child: SettingCard(
                              icon: Icons.logout_outlined, text: 'Sign Out'),
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
