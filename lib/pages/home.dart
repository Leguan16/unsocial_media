import 'package:flutter/material.dart';
import 'package:unsocial_media/pages/profile.dart';
import 'package:unsocial_media/pages/register.dart';
import 'package:unsocial_media/user_management/user_manager.dart';
import 'package:unsocial_media/widgets/bottom_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Start"),
        actions: [
          IconButton(
              onPressed: () {
                UserManager.checkIfLoggedIn(context);

                Navigator.pushNamed(context, Profile.route,
                    arguments: UserManager.getUser());
              },
              icon: Icon(Icons.account_circle_outlined))
        ],
      ),
      bottomNavigationBar: AppBarBottom(),
    );
  }
}
