import 'package:flutter/material.dart';

class InvalidPasswordDialog extends StatelessWidget {
  const InvalidPasswordDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Invalid passwprd!"),
      content: const Text(
          "The provided password is incorrect"),
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
