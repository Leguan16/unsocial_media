import 'package:flutter/material.dart';
import 'package:unsocial_media/pages/settings.dart';
import 'package:unsocial_media/user_management/user_manager.dart';

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<ListTile> _drawerContent = [
      ListTile(
        title: const Text("Settings"),
        trailing: const Icon(Icons.settings),
        onTap: () {
          Navigator.pushNamed(context, SettingsPage.route);
        },
      ),
      ListTile(
        title: const Text("Log Out"),
        trailing: const Icon(Icons.logout),
        onTap: () {
          UserManager.logout();
          Navigator.pushNamedAndRemoveUntil(context, "/", (_) => false);
        },
      )
    ];

    return Drawer(
      child: ListView.separated(
          itemBuilder: (context, index) => _drawerContent[index],
          separatorBuilder: (context, index) => const Divider(
                color: Colors.green,
              ),
          itemCount: _drawerContent.length),
    );
  }
}
