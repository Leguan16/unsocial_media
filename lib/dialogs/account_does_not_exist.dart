import 'package:flutter/material.dart';
import 'package:unsocial_media/pages/register.dart';

class AccountDoesNotExistDialog extends StatelessWidget {
  const AccountDoesNotExistDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Error"),
      content: Text("Account does not exist!"),
      actions: [
        ElevatedButton(
            onPressed: () => Navigator.pop(context), child: Text("OK")),
        ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, Register.route),
            child: Text("Register")),
      ],
    );
  }
}
