import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ImageRequests {
  static postImage(File image) async {
    final files = <http.MultipartFile>[];

    files.add(http.MultipartFile.fromBytes('image', image.readAsBytesSync(),
        filename: image.path));

    final request = http.MultipartRequest(
        "POST", Uri.parse("https://api.imgur.com/3/upload"));

    request.files.addAll(files);

    if (dotenv.isInitialized) {
      request.headers.addAll(
          {"Authorization": "Bearer ${dotenv.env["imgurAccessToken"]}"});

      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print(jsonDecode(response.body)['data']['link']);
        return jsonDecode(response.body)['data']['link'];
      }
    } else {
      return -1;
    }

    return -200;
  }
}
