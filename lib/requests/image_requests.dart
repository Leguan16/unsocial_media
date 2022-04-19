import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ImageRequests {
  static postImage(File image) async {
    final files = <http.MultipartFile>[];

    files.add(http.MultipartFile.fromBytes('image', image.readAsBytesSync(),
        filename: image.path));

    final request = http.MultipartRequest(
        "POST", Uri.parse("https://api.imgur.com/3/upload"));

    request.files.addAll(files);

    request.headers.addAll(
        {"Authorization": "Bearer b12ee3d46f9936102e3c5ad5ffdad77eede09c6e"});

    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data']['link'];
    }

    return false;
  }
}
