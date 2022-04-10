import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'pages/createPost.dart';
import 'pages/home.dart';
import 'pages/login.dart';
import 'pages/profile.dart';
import 'pages/register.dart';
import 'pages/search.dart';
import 'pages/settings.dart';
import 'pages/settings/settings_profile.dart';

void main() async {
  await dotenv.load();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Unsocial Media",
      initialRoute: "/",
      routes: {
        "/": (_) => HomePage(),
        Profile.route: (_) => Profile(),
        Register.route: (_) => Register(),
        LoginPage.route: (_) => LoginPage(),
        CreatePostPage.route: (_) => CreatePostPage(),
        SearchPage.route: (_) => SearchPage(),
        SettingsPage.route: (_) => SettingsPage(),
        ProfileSettings.route: (_) => ProfileSettings(),
      },
      darkTheme: ThemeData.dark().copyWith(
          focusColor: Colors.red,
          colorScheme: ThemeData().colorScheme.copyWith(primary: Colors.red),
          appBarTheme: AppBarTheme(
              backgroundColor: ThemeData.dark().scaffoldBackgroundColor),
          errorColor: Colors.tealAccent),
    );
  }
}
