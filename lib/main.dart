import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/firebase_options.dart';
import 'package:news_app/service/config/remote_config.dart';
import 'package:news_app/utils/constants/app_constant.dart';
import 'package:news_app/view/auth/toggle.dart';
import 'package:news_app/view/home/home_screen.dart';
import 'package:news_app/view/home/news_detail_screen.dart';
import 'package:news_app/view/main_home_screen.dart';
import 'package:news_app/view/search/search_screen.dart';
import 'package:news_app/view/shorts_view/account_screen.dart';
import 'package:news_app/view_model/auth_view_model.dart';
import 'package:news_app/view_model/news_view_model.dart';
import 'package:news_app/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final remoteConfigService = RemoteConfigService();
  await remoteConfigService.initialize();
  runApp(const MyApp());
}

// 765a0808b9524429ba0e5f780583e61a

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserViewModel()),
          ChangeNotifierProvider(create: (context) => AuthViewModel()),
          ChangeNotifierProvider(create: (context) => NewsViewModel())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MyNews',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppConstant.greyColor),
            textTheme: GoogleFonts.poppinsTextTheme(),
            useMaterial3: true,
          ),
          home: const AuthWrapper(),
        ));
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            return const MainHomePage();
          } else {
            return const Toggle();
          }
        });
  }
}
