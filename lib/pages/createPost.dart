import 'package:flutter/material.dart';
import 'package:unsocial_media/widgets/bottom_app_bar.dart';

class CreatePostPage extends StatelessWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  static const String route = "/create";

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Create Post"),
      ),
      bottomNavigationBar: AppBarBottom(),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              //fix that textfield starts scrolling when it reaches the keyboard
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                reverse: true,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Tell us something!",
                    border: InputBorder.none,
                  ),
                  onFieldSubmitted: (String text) {
                    print(text);
                  },
                  maxLines: null,
                  scrollController: ScrollController(),
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
