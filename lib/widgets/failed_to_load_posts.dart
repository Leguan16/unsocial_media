import 'package:flutter/material.dart';

class FailedToLoadPosts extends StatelessWidget {
  const FailedToLoadPosts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(
            Icons.cloud_off,
            size: 30,
          ),
          Text("No Connection!"),
        ],
      ),
    );
  }
}
