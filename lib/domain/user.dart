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
}
