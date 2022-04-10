import 'package:flutter/material.dart';
import 'package:unsocial_media/pages/createPost.dart';
import 'package:unsocial_media/pages/home.dart';
import 'package:unsocial_media/pages/search.dart';
import 'package:unsocial_media/user_management/user_manager.dart';

import '../pages/register.dart';

class AppBarBottom extends StatelessWidget {
  const AppBarBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) => HomePage(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
                (route) => false,
              );
            },
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.31,
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              if (UserManager.userLoggedIn()) {
                Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        CreatePostPage(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                  (route) => false,
                );
              } else {
                Navigator.pushNamed(context, Register.route);
              }
            },
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.31,
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      SearchPage(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
