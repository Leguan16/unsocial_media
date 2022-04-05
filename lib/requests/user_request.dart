import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:unsocial_media/domain/user.dart';
import 'package:http/http.dart' as http;

class UserRequests {
  static Future<dynamic> postUser(User user, String hashedPassword) async {
    String body = jsonEncode({
      'id': user.id,
      'username': user.name,
      'profileAvatar': user.profileAvatar ?? 'null',
      'passwordHash': hashedPassword
    });

    if (dotenv.isInitialized) {
      await http.post(
        Uri.parse('${dotenv.env['flutterUrl']!}/users.json'),
        body: body,
      );
    }
  }
}
