import 'dart:convert';

import 'package:unsocial_media/requests/user_request.dart';
import 'package:uuid/uuid.dart';

import 'user.dart';

class Post {
  late String id;
  String content;
  late User author;
  late String usernameOfAuthor;
  DateTime time;
  late int dislikes;

  Post(this.content, this.usernameOfAuthor, this.time,
      [User? author, String? id, int? dislikes]) {
    this.id = id ?? const Uuid().v1();
    this.dislikes = dislikes ?? 0;

    if (author != null) {
      this.author = author;
    }
  }

  factory Post.fromJson(Map<String, dynamic> json, User author) {
    return Post(
      json['content'],
      json['author'],
      DateTime.fromMillisecondsSinceEpoch(json['time']),
      author,
      json['id'],
      json['dislikes'],
    );
  }

  String toJson() {
    return jsonEncode({
      "id": id,
      "content": content,
      "author": author.name,
      "time": time.millisecondsSinceEpoch,
      "dislikes": dislikes,
    });
  }

  fetchAuthor() async {
    var possibleUser = await UserRequests.getUser(usernameOfAuthor);

    if (possibleUser.runtimeType == User) {
      author = possibleUser;
    }
  }

  @override
  String toString() {
    return 'Post{id: $id, content: $content, usernameOfAuthor: $usernameOfAuthor, time: $time, dislikes: $dislikes}';
  }
}
