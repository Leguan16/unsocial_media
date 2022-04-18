import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
          leading: post.author.profileAvatar == null
              ? Icon(
                  Icons.account_circle_outlined,
                  size: 40,
                )
              : CircleAvatar(
                  radius: 20,
                  //todo change this to NetworkImage
                  backgroundImage: FileImage(post.author.profileAvatar!),
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
