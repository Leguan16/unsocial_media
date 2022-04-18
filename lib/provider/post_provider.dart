import 'package:unsocial_media/requests/post_request.dart';

import '../domain/post.dart';
import '../domain/user.dart';

class PostProvider {
  static List<Post> _posts = [];

  static Future<void> fetch() async {
    var posts = await PostRequests.fetchPosts();

    _posts = posts;

    for (var element in _posts) {
      element.fetchAuthor();
    }
  }

  static List<Post> getPostsOfUser(User user) {
    var posts = _posts
        .where((element) => element.usernameOfAuthor == user.name)
        .toList();

    posts.sort(
      (a, b) => b.time.difference(a.time).inMilliseconds,
    );

    return posts;
  }
}
