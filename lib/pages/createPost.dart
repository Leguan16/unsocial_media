import 'package:flutter/material.dart';
import 'package:unsocial_media/pages/register.dart';
import 'package:unsocial_media/user_management/user_manager.dart';
import 'package:unsocial_media/widgets/bottom_app_bar.dart';

import '../domain/post.dart';

class CreatePostPage extends StatelessWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  static const String route = "/create";

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final TextEditingController contentController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Create Post"),
        actions: [
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (!UserManager.userLoggedIn()) {
                  Navigator.pushNamed(context, Register.route);
                  return;
                }

                UserManager.getUser()!.addPost(Post(
                    contentController.text,
                    UserManager.getUser()!.name,
                    DateTime.now(),
                    UserManager.getUser()!));
              }
            },
          )
        ],
      ),
      bottomNavigationBar: AppBarBottom(),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              //todo make it, so that the textfield starts scrolling when it reaches the keyboard
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                reverse: true,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Tell us something!",
                    border: InputBorder.none,
                  ),
                  maxLines: null,
                  scrollController: ScrollController(),
                  style: TextStyle(fontSize: 20.0),
                  controller: contentController,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
