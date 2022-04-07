import 'package:flutter/material.dart';
import 'package:unsocial_media/pages/settings.dart';
import 'package:unsocial_media/user_management/user_manager.dart';

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final List<ListTile> _drawerContent = [
      ListTile(
        title: Text("Settings"),
        trailing: Icon(Icons.settings),
        onTap: () {
          Navigator.pushNamed(context, SettingsPage.route);
        },
      ),
      ListTile(
        title: Text("Log Out"),
        trailing: Icon(Icons.logout),
        onTap: () {
          UserManager.logout();
          Navigator.pushNamedAndRemoveUntil(context, "/", (_) => false);
        },
      )
    ];

    return Drawer(
      child: ListView.separated(
          itemBuilder: (context, index) => _drawerContent[index],
          separatorBuilder: (context, index) => Divider(
                color: Colors.green,
              ),
          itemCount: _drawerContent.length),

    );
  }
}
