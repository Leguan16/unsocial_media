import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:unsocial_media/requests/post_request.dart';

import 'post.dart';

class User {
  String name;
  String id;
  String? profileAvatar;
  late String hashedPassword;
  String? profileBanner;
  List<String> posts = [];

  User(this.name, this.id, String password,
      [String? profileAvatarUrl,
      String? hashedPassword,
      String? profileBannerUrl]) {
    if (profileAvatarUrl != null) {
      profileAvatar = profileAvatarUrl;
    }

    if (profileBannerUrl != null) {
      profileBanner = profileBannerUrl;
    }

    this.hashedPassword =
        hashedPassword ?? sha256.convert(utf8.encode(password)).toString();
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['username'], json['id'], json['passwordHash'],
        json['profileAvatarUrl'], json['passwordHash']);
  }

  addPost(Post post) {
    posts.add(post.id);

    PostRequests.postPost(post);
  }

  loadPosts() async {}
}
