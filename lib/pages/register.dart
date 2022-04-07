import 'package:flutter/material.dart';
import 'package:unsocial_media/domain/user.dart';

import '../dialogs/already_logged_in.dart';
import '../dialogs/username_already_in_use.dart';
import '../user_management/user_manager.dart';
import 'login.dart';
import 'profile.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);

  static const String route = "/register";

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Username",
              ),
              controller: usernameController,
              validator: validateUsername,
            ),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
              ),
              controller: passwordController,
              validator: validatePassword,
            ),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Repeat Password",
              ),
              controller: confirmPasswordController,
              validator: validatePassword,
            ),
            ElevatedButton(
              child: const Text("Register"),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  var response = await UserManager.createUser(
                      usernameController.text, passwordController.text);

                  if (response == 1) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const AlreadyLoggedInDialog();
                        });
                  }

                  if(response.runtimeType == User) {
                    Navigator.pushNamed(context, Profile.route);
                  }

                  if (!response) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const UserNameAlreadyTakenDialog();
                        });
                  }

                }
              },
            ),
            TextButton(
              onPressed: () =>
                  Navigator.popAndPushNamed(context, LoginPage.route),
              child: const Text("Already registered? Log in"),
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

    if (passwordController.text != confirmPasswordController.text) {
      return "passwords don't match";
    }

    return null;
  }
}
