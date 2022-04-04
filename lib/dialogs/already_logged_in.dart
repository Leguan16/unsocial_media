import 'package:flutter/material.dart';

class AlreadyLoggedInDialog extends StatelessWidget {
  const AlreadyLoggedInDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Error!"),
      content: Text(
          "You are already logged in. Please log out!"),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("OK")),
      ],
    );
  }
}
