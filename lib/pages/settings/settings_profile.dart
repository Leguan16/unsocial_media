import 'package:flutter/material.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  static const String route = "/settings/profile";

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Settings"),
      ),
      body: Card(
        child: GestureDetector(
          child: Text("HAHAH"),
        ),
      ),
    );
  }
}
