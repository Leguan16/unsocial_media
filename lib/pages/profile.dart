import 'package:flutter/material.dart';
import 'package:unsocial_media/domain/user.dart';
import 'package:unsocial_media/user_management/user_manager.dart';
import 'package:unsocial_media/widgets/failed_to_load_posts.dart';
import 'package:unsocial_media/widgets/no_posts.dart';
import 'package:unsocial_media/widgets/post_widget.dart';

import '../domain/post.dart';
import '../drawers/profile_drawer.dart';
import '../provider/post_provider.dart';
import '../widgets/bottom_app_bar.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  static const String route = "/profile";

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Future _posts;

  @override
  Widget build(BuildContext context) {
    User user = ModalRoute.of(context)!.settings.arguments as User;

    return Scaffold(
      endDrawer:
          user.name == UserManager.getUser()!.name ? ProfileDrawer() : null,
      bottomNavigationBar: AppBarBottom(),
      body: NestedScrollView(
        physics: NeverScrollableScrollPhysics(),
        headerSliverBuilder: (context, _) {
          return [
            SliverAppBar(
              floating: false,
              pinned: true,
              expandedHeight: 130,
              flexibleSpace: FlexibleSpaceBar(
                  background: user.profileBannerUrl == null
                      ? ColoredBox(color: Colors.white)
                      : Image.network(
                          user.profileBannerUrl!,
                          errorBuilder: (context, error, stackTrace) =>
                              ColoredBox(color: Colors.white),
                        )),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            user.profileAvatarUrl == null
                                ? Icon(
                                    Icons.account_circle_outlined,
                                    size: 50,
                                  )
                                : CircleAvatar(
                                    radius: 30,
                                    //todo change this to networkImage
                                    // backgroundImage:
                                    //     NetworkImage(user.profileAvatarUrl!),
                                    backgroundImage: Image.network(
                                      user.profileAvatarUrl!,
                                      errorBuilder:
                                          (context, error, stackTrace) => Icon(
                                        Icons.account_circle_outlined,
                                        size: 50,
                                      ),
                                    ).image,
                                  ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.1,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  user.name,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
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
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    return FailedToLoadPosts();
                  } else {
                    return buildPosts(user);
                  }
              }
            },
            future: _posts),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _posts = PostProvider.fetch();
  }

  buildPosts(User user) {
    List<Post> posts = PostProvider.getPostsOfUser(user);

    if (posts.isEmpty) {
      return NoPosts();
    }

    return RefreshIndicator(
      child: ListView.separated(
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
