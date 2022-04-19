import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:unsocial_media/domain/user.dart';
import 'package:unsocial_media/requests/user_request.dart';

import '../domain/post.dart';

class PostRequests {
  static postPost(Post post) async {
    String body = jsonEncode({
      "id": post.id,
      "content": post.content,
      "author": post.author.name,
      "time": post.time.millisecondsSinceEpoch,
      "dislikes": post.dislikes,
    });

    if (dotenv.isInitialized) {
      var response = await http.post(
        Uri.parse('${dotenv.env['firebaseUrl']!}/posts.json'),
        body: body,
      );

      return response.statusCode;

      // await http.post(
      //   Uri.parse(
      //       '${dotenv.env['firebaseUrl']!}/users/${post.author.name.toLowerCase()}/posts.json'),
      //   body: jsonEncode(post.id),
      // );
    }
  }

  //todo remove ?
  static Future<List<Post>> fetchPosts() async {
    var response =
        await http.get(Uri.parse('${dotenv.env['firebaseUrl']!}/posts.json'));

    List<Post> list = [];
    if (response.statusCode == 200) {
      if (response.body == "null") {
        return [];
      }

      var posts =
          (json.decode(response.body) as Map<String, dynamic>).values.toList();

      for (var post in posts) {
        var possibleAuthor = await UserRequests.getUser(post['author']);

        if (possibleAuthor.runtimeType == User) {
          list.add(Post.fromJson(post, possibleAuthor));
        }
      }
    }
    return list;
  }
}
