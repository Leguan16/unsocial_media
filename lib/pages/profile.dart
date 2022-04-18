import 'package:flutter/material.dart';
import 'package:unsocial_media/widgets/post_widget.dart';

import '../domain/post.dart';
import '../drawers/profile_drawer.dart';
import '../provider/post_provider.dart';
import '../user_management/user_manager.dart';
import '../widgets/bottom_app_bar.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  static const String route = "/profile";

  @override
  Widget build(BuildContext context) {
    var posts = PostProvider.fetch();

    return Scaffold(
      endDrawer: ProfileDrawer(),
      bottomNavigationBar: AppBarBottom(),
      body: NestedScrollView(
        headerSliverBuilder: (context, _) {
          return [
            SliverAppBar(
              floating: false,
              pinned: true,
              expandedHeight: 130,
              flexibleSpace: FlexibleSpaceBar(
                background: ColoredBox(color: Colors.white),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            UserManager.getUser()!.profileAvatar == null
                                ? Icon(
                                    Icons.account_circle_outlined,
                                    size: 50,
                                  )
                                : CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                        UserManager.getUser()!.profileAvatar!),
                                  ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.1,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  UserManager.getUser()!.name,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ];
        },
        body: FutureBuilder(
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : buildPosts();
            },
            future: posts),
      ),
    );
  }

  buildPosts() {
    List<Post> posts = PostProvider.getPostsOfUser(UserManager.getUser()!);

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
