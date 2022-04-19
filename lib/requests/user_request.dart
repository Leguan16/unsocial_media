import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:unsocial_media/domain/user.dart';

class UserRequests {
  static postUser(User user) async {
    String body = jsonEncode({
      'id': user.id,
      'username': user.name,
      'profileAvatarUrl': user.profileAvatarUrl,
      'passwordHash': user.hashedPassword,
      'profileBannerUrl': user.profileBannerUrl,
      'bio': user.bio,
    });

    if (dotenv.isInitialized) {
      var response = await http.post(
        Uri.parse(
            '${dotenv.env['firebaseUrl']!}/users/${user.name.toLowerCase()}.json'),
        body: body,
      );

      return response.statusCode;
    }
  }

  static Future<dynamic> getUser(String username) async {
    if (dotenv.isInitialized) {
      http.Response response;
      try {
        response = (await http.get(Uri.parse(
            '${dotenv.env['firebaseUrl']!}/users/${username.toLowerCase()}.json')));
      } on SocketException {
        return 503;
      }

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
}
