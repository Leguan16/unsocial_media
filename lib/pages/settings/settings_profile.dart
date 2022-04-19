import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unsocial_media/dialogs/no_connection.dart';
import 'package:unsocial_media/dialogs/unknown.dart';
import 'package:unsocial_media/pages/profile.dart';
import 'package:unsocial_media/requests/image_requests.dart';

import '../../user_management/user_manager.dart';
import '../../widgets/bottom_app_bar.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  static const String route = "/settings/profile";

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  Future pickImageForBanner() async {
    final image = await pickImage();

    try {
      var url = await ImageRequests.postImage(image);

      if (url.runtimeType == String) {
        UserManager.getUser()!.setProfileBannerUrl(url);

        setState(() {
          UserManager.getUser()!.profileBanner = image;
        });
      } else {
        showDialog(
            context: context,
            builder: (context) =>
                UnknownErrorDialog(url.runtimeType == int ? url : -100));
      }
    } on SocketException {
      showDialog(context: context, builder: (context) => NoConnectionDialog());
    }
  }

  Future pickImageForAvatar() async {
    final image = await pickImage();

    try {
      var url = await ImageRequests.postImage(image);

      if (url.runtimeType == String) {
        UserManager.getUser()!.setProfileAvatarUrl(url);

        setState(() {
          UserManager.getUser()!.profileAvatar = image;
        });
      } else {
        showDialog(
            context: context,
            builder: (context) =>
                UnknownErrorDialog(url.runtimeType == int ? url : -100));
      }
    } on SocketException {
      showDialog(context: context, builder: (context) => NoConnectionDialog());
    }
  }

  pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) {
      return;
    }

    return File(image.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppBarBottom(),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: 130,
                decoration: BoxDecoration(
                    color: Colors.white,
                    image: UserManager.getUser()!.profileBannerUrl == null
                        ? null
                        : DecorationImage(
                            image: Image.network(
                            UserManager.getUser()!.profileBannerUrl!,
                            errorBuilder: (context, error, stackTrace) =>
                                Text(""),
                          ).image)),
              ),
              GestureDetector(
                onTap: () async => pickImageForBanner(),
                child: Container(
                  color: Colors.black54,
                  height: 130,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt,
                        size: 70,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      children: [
                        UserManager.getUser()!.profileAvatarUrl == null
                            ? Icon(
                                Icons.account_circle_outlined,
                                size: 50,
                              )
                            : CircleAvatar(
                                radius: 25,
                                backgroundImage: Image.network(
                                  UserManager.getUser()!.profileAvatarUrl!,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(
                                    Icons.account_circle_outlined,
                                    size: 50,
                                  ),
                                ).image,
                              ),
                        GestureDetector(
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.black54,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera_alt,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                          onTap: () async => pickImageForAvatar(),
                        ),
                      ],
                    ),
                    TextButton(
                      child: Text("Save"),
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Profile.route, (route) => false,
                            arguments: UserManager.getUser());
                      },
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
