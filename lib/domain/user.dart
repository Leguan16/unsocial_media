
import 'dart:convert';

import 'package:crypto/crypto.dart';

class User {
  String name;
  String id;
  String? profileAvatar;
  late String hashedPassword;

  User(this.name, this.id, String password, [String? profileAvatarUrl]) {
    if(profileAvatarUrl != null) {
      setProfileAvatar(profileAvatarUrl);
    }

    hashedPassword = sha256.convert(utf8.encode(password)).toString();
  }

  setProfileAvatar(String profileAvatarUrl) {
    profileAvatar = profileAvatarUrl;
  }


}