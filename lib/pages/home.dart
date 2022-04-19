import 'package:flutter/material.dart';
import 'package:unsocial_media/pages/profile.dart';
import 'package:unsocial_media/pages/register.dart';
import 'package:unsocial_media/provider/post_provider.dart';
import 'package:unsocial_media/user_management/user_manager.dart';
import 'package:unsocial_media/widgets/bottom_app_bar.dart';
import 'package:unsocial_media/widgets/failed_to_load_posts.dart';
import 'package:unsocial_media/widgets/no_posts.dart';

import '../domain/post.dart';
import '../widgets/post_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future _posts;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Start"),
        actions: [
          IconButton(
              onPressed: () {
                if (!UserManager.userLoggedIn()) {
                  Navigator.of(context).pushNamed(Register.route);
                } else {
                  Navigator.pushNamed(context, Profile.route,
                      arguments: UserManager.getUser());
                }
              },
              icon: Icon(Icons.account_circle_outlined))
        ],
      ),
      bottomNavigationBar: AppBarBottom(),
      body: FutureBuilder(
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.hasError) {
                return FailedToLoadPosts();
              } else {
                return buildPosts();
              }
          }
        },
        future: _posts,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _posts = PostProvider.fetch();
  }

  buildPosts() {
    List<Post> posts = PostProvider.getAllPosts();

    if (posts.isEmpty) {
      return NoPosts();
    }

    return RefreshIndicator(
      child: ListView.separated(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          var post = posts[index];
          return PostWidget(post);
        },
        separatorBuilder: (_, index) {
          return Divider(
            color: Colors.amber,
          );
        },
      ),
      onRefresh: () async {
        await PostProvider.fetch();
        setState(() {});
      },
    );
  }
}
