import 'package:flutter/material.dart';

class UserNameAlreadyTakenDialog extends StatelessWidget {
  const UserNameAlreadyTakenDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Error!"),
      content: const Text(
          "This username is already taken"),
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
