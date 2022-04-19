import 'package:flutter/material.dart';
import 'package:unsocial_media/dialogs/error_loading_posts.dart';
import 'package:unsocial_media/pages/profile.dart';
import 'package:unsocial_media/pages/register.dart';
import 'package:unsocial_media/provider/post_provider.dart';
import 'package:unsocial_media/user_management/user_manager.dart';
import 'package:unsocial_media/widgets/bottom_app_bar.dart';

import '../domain/post.dart';
import '../widgets/post_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var posts = PostProvider.fetch();

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
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                showDialog(
                    context: context,
                    builder: (context) => ErrorLoadingPostsDialog());

                return Text("Failed to load Posts");
              } else {
                return buildPosts();
              }
          }
        },
        future: posts,
      ),
    );
  }

  buildPosts() {
    List<Post> posts = PostProvider.getAllPosts();

    if (posts.isEmpty) {
      return Text("No Posts");
    }

    return ListView.separated(
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
    );
  }
}
