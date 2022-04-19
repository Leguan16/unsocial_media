import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ImageRequests {
  static Future<String> postImage(File image) async {
    String body = jsonEncode({
      "image": image.readAsBytesSync(),
    });

    var response = await http.post(Uri.parse("https://api.imgur.com/3/upload"),
        body: body, headers: {"Authorization": "Client-ID 0caf98b9c83fbee"});

    print(response.statusCode);

    print(response.body);

    return "w";
  }
}
