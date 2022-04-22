import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';

class User {
  String name;
  String id;
  String? profileAvatarUrl;
  File? profileAvatar;
  late String hashedPassword;
  String? profileBannerUrl;
  File? profileBanner;
  late String bio;

  User(this.name, this.id, String password,
      [String? profileAvatarUrl,
      String? hashedPassword,
      String? profileBannerUrl,
      String? bio]) {
    if (profileAvatarUrl != null) {
      this.profileAvatarUrl = profileAvatarUrl;
    }

    if (profileBannerUrl != null) {
      this.profileBannerUrl = profileBannerUrl;
    }

    this.hashedPassword =
        hashedPassword ?? sha256.convert(utf8.encode(password)).toString();

    this.bio = bio ?? "";
  }

  setProfileBannerUrl(String url) {
    profileBannerUrl = url;
    //UserRequests.postUser(this);
  }

  setProfileAvatarUrl(String url) {
    profileAvatarUrl = url;
    //UserRequests.postUser(this);
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        json['username'],
        json['id'],
        json['passwordHash'],
        json['profileAvatarUrl'],
        json['passwordHash'],
        json['profileBannerUrl'],
        json['bio']);
  }

  String toJson() {
    return jsonEncode({
      'id': id,
      'username': name,
      'profileAvatarUrl': profileAvatarUrl,
      'passwordHash': hashedPassword,
      'profileBannerUrl': profileBannerUrl,
      'bio': bio,
    });
  }

  @override
  String toString() {
    return 'User{name: $name, id: $id, profileAvatarUrl: $profileAvatarUrl, profileAvatar: $profileAvatar, hashedPassword: $hashedPassword, profileBannerUrl: $profileBannerUrl, profileBanner: $profileBanner, bio: $bio}';
  }
}
