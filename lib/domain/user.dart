
import 'dart:convert';

import 'package:crypto/crypto.dart';

class User {
  String name;
  String id;
  String? profileAvatar;
  late String hashedPassword;

  User(this.name, this.id, String password, [String? profileAvatarUrl, String? hashedPassword]) {
    if(profileAvatarUrl != null) {
      setProfileAvatar(profileAvatarUrl);
    }

    this.hashedPassword = hashedPassword ?? sha256.convert(utf8.encode(password)).toString();
  }

  setProfileAvatar(String profileAvatarUrl) {
    profileAvatar = profileAvatarUrl;
  }

  factory User.fromJson(Map<String, dynamic> json) {

    return User(
      json['username'],
      json['id'],
      json['passwordHash'],
      json['profileAvatarUrl'],
      json['passwordHash'],
    );

  }

}