import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:unsocial_media/requests/user_request.dart';
import 'package:uuid/uuid.dart';

import '../domain/user.dart';

class UserManager {
  static User? _user;

  static User? getUser() {
    return _user;
  }

  static createUser(String username, String password) async {
    if (_user != null) {
      return 1;
    }

    var response = await UserRequests.getUser(username);

    if (response == 503) {
      return response;
    }

    if (response.runtimeType == User) {
      return false;
    }

    _user = User(username, const Uuid().v1(), password);

    response = await UserRequests.postUser(_user!);

    if (response == 200) {
      return login();
    }
    return response;
  }

  static login([String? username, String? password]) async {
    if (username != null && password != null) {
      if (_user != null) {
        return 1;
      }

      var response = await UserRequests.getUser(username);

      if (response.runtimeType == User) {
        if ((response as User).hashedPassword !=
            sha256.convert(utf8.encode(password)).toString()) {
          return 2;
        }

        _user = response;
      }

      return response;
      //todo request check if user in db and set user
    }

    return _user!;
  }

  static logout() {
    _user = null;
  }

  static bool userLoggedIn() {
    return _user != null;
  }
}
