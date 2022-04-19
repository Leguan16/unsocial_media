import 'package:flutter/material.dart';

class UnknownErrorDialog extends StatelessWidget {
  int id;

  UnknownErrorDialog(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Unknown Error!"),
      content: Text("An unknown error occurred\nID: $id"),
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
