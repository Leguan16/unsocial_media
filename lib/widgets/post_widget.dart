import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unsocial_media/pages/profile.dart';
import 'package:unsocial_media/pages/register.dart';
import 'package:unsocial_media/user_management/user_manager.dart';

import '../domain/post.dart';

class PostWidget extends StatelessWidget {
  Post post;

  PostWidget(this.post, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: GestureDetector(
            child: const Icon(
              Icons.account_circle_outlined,
              size: 40,
            ),
            // post.author.profileAvatarUrl == null
            //     ? Icon(
            //         Icons.account_circle_outlined,
            //         size: 40,
            //       )
            //     : CircleAvatar(
            //         radius: 20,
            //         //todo change this to NetworkImage
            //         backgroundImage: Image.network(
            //           post.author.profileAvatarUrl!,
            //           errorBuilder: (context, error, stackTrace) => Icon(
            //             Icons.account_circle_outlined,
            //             size: 40,
            //           ),
            //         ).image,
            //       ),
            onTap: () {
              if (UserManager.userLoggedIn()) {
                Navigator.pushNamed(context, Profile.route,
                    arguments: post.author);
              } else {
                Navigator.pushNamed(context, Register.route);
              }
            },
          ),
          title: Row(
            children: [
              Text(post.author.name),
              Text(" | " + DateFormat.yMd().add_Hms().format(post.time),
                  style: TextStyle(color: Colors.white.withOpacity(0.5)))
            ],
          ),
          subtitle: Text(post.content),
        ),
      ],
    );
  }
}
