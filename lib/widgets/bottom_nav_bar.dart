import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unsocial_media/pages/createPost.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: IconButton(
            icon: Icon(Icons.home_outlined),
            onPressed: () {
              setState(() {
                Navigator.pushNamed(context, "/");
                currentIndex = 0;
              });
            },
          ),
          activeIcon: IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              setState(() {
                Navigator.pushNamed(context, CreatePostPage.route);
                currentIndex = 1;
              });
            },
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          label: "Create Post",
          icon: Icon(Icons.add),
        ),
      ],
    );
  }
}
