import 'package:flutter/material.dart';
import 'package:unsocial_media/widgets/bottom_app_bar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  static const String route = "/search";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
      bottomNavigationBar: const AppBarBottom(),
    );
  }
}
