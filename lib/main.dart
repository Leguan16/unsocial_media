import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:unsocial_media/domain/user.dart';
import 'package:unsocial_media/pages/createPost.dart';
import 'package:unsocial_media/pages/home.dart';
import 'package:unsocial_media/pages/login.dart';
import 'package:unsocial_media/pages/profile.dart';
import 'package:unsocial_media/pages/register.dart';
import 'package:unsocial_media/pages/search.dart';
import 'package:unsocial_media/pages/settings.dart';
import 'package:unsocial_media/pages/settings/settings_profile.dart';
import 'package:unsocial_media/requests/user_request.dart';

void main() async{
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
