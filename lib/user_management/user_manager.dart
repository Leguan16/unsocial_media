import 'package:uuid/uuid.dart';

import '../domain/user.dart';

class UserManager {
  static User? _user;

  static User? getUser() {
    return _user;
  }

  static createUser(String username, String password) {
    if(_user != null) {
      return 1;
    }

    //todo request, add user to db

    _user = User(username, Uuid().v1());

    return login();
  }

  static User? login([String? username, String? password]) {
    if(username != null && password != null) {
      if(_user != null) {
        return null;
      }

      //todo request check if user in db and set user
    }

    return _user!;
  }

  static logout() {
    _user = null;
  }
}