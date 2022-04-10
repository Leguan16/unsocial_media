import 'package:flutter/material.dart';

import '../drawers/profile_drawer.dart';
import '../user_management/user_manager.dart';
import '../widgets/bottom_app_bar.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  static const String route = "/profile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      endDrawer: ProfileDrawer(),
      bottomNavigationBar: AppBarBottom(),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.20,
            child: Card(
              child: UserManager.getUser()!.profileAvatar == null
                  ? Icon(Icons.account_circle_outlined, size: 100)
                  : Image.network(UserManager.getUser()!.profileAvatar!),
            ),
          )
        ],
      ),
    );
  }
}
