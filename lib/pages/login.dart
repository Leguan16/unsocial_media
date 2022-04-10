import 'package:flutter/material.dart';
import 'package:unsocial_media/dialogs/account_does_not_exist.dart';
import 'package:unsocial_media/dialogs/invalid_password.dart';
import 'package:unsocial_media/pages/register.dart';

import '../dialogs/already_logged_in.dart';
import '../domain/user.dart';
import '../user_management/user_manager.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  static const String route = "/login";

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: "Username",
              ),
              controller: usernameController,
              validator: validateUsername,
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
              ),
              controller: passwordController,
              validator: validatePassword,
            ),
            ElevatedButton(
              child: Text("Login"),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  var response = await UserManager.login(
                      usernameController.text, passwordController.text);

                  if (response == 1) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlreadyLoggedInDialog();
                        });
                  } else if (response == 2) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return InvalidPasswordDialog();
                        });
                  } else if (response.runtimeType == User) {
                    Navigator.pushNamed(context, "/profile");
                  } else if (!response) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AccountDoesNotExistDialog();
                        });
                  }
                }
              },
            ),
            TextButton(
              onPressed: () =>
                  Navigator.popAndPushNamed(context, Register.route),
              child: Text("Register now"),
            ),
          ],
        ),
      ),
    );
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a username";
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return "Please enter a password";
    }

    return null;
  }
}
