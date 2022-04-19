import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:unsocial_media/domain/user.dart';

class UserRequests {
  static postUser(User user) async {
    String body = jsonEncode({
      'id': user.id,
      'username': user.name,
      'profileAvatar': user.profileAvatar,
      'passwordHash': user.hashedPassword
    });

    if (dotenv.isInitialized) {
      await http.post(
        Uri.parse(
            '${dotenv.env['firebaseUrl']!}/users/${user.name.toLowerCase()}.json'),
        body: body,
      );
    }
  }

  static Future<dynamic> getUser(String username) async {
    if (dotenv.isInitialized) {
      var response = await http.get(Uri.parse(
          '${dotenv.env['firebaseUrl']!}/users/${username.toLowerCase()}.json'));

      print(response.body);

      if (response.body == 'null') {
        return false;
      }

      if (response.statusCode == 200) {
        return User.fromJson(
            ((jsonDecode(response.body) as Map<String, dynamic>)
                .values
                .toList()[0] as Map<String, dynamic>));
      }

      return false;
    }
  }

  static Future<dynamic> getAllUsers() async {}
}
