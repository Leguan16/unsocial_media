import 'package:flutter/material.dart';
import 'package:unsocial_media/pages/settings/settings_profile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  static const String route = "/settings";

  @override
  Widget build(BuildContext context) {
    final items = [
      ListTile(
        title: Text("Profile"),
        onTap: () {
          Navigator.of(context).pushNamed(ProfileSettings.route);
        },
      ),
    ];
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
        ),
        body: ListView.separated(
            itemBuilder: (context, index) => items[index],
            separatorBuilder: (context, index) => Divider(
                  color: Colors.amber,
                ),
            itemCount: items.length));
  }
}
