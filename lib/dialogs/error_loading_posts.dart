import 'package:flutter/material.dart';

class ErrorLoadingPostsDialog extends StatelessWidget {
  const ErrorLoadingPostsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Error Loading Posts!"),
      content: const Text("There has been an error while loading the Posts"),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("OK")),
      ],
    );
  }
}
