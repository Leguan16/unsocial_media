import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../user_management/user_manager.dart';
import '../../widgets/bottom_app_bar.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  static const String route = "/settings/profile";

  Future pickAnImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
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
                    image: UserManager.getUser()!.profileBanner == null
                        ? null
                        : DecorationImage(
                            image: NetworkImage(
                                UserManager.getUser()!.profileBanner!))),
              ),
              GestureDetector(
                onTap: () async => pickAnImage(),
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
                        UserManager.getUser()!.profileAvatar == null
                            ? Icon(
                                Icons.account_circle_outlined,
                                size: 50,
                              )
                            : CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(
                                    UserManager.getUser()!.profileAvatar!),
                              ),
                        CircleAvatar(
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
                      ],
                    ),
                    TextButton(
                      child: Text("Save"),
                      onPressed: () {},
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
