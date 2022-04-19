import 'package:flutter/material.dart';

class NoPosts extends StatelessWidget {
  const NoPosts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.block,
            size: 30,
          ),
          Text("No Posts!"),
        ],
      ),
    );
  }
}
