import 'package:flutter/material.dart';
import 'package:instagram/view/authentication/user_model.dart';

class ChatPage extends StatelessWidget {
  final String currentUserId;
  final UserModel otherUser;

  const ChatPage({Key? key, required this.currentUserId, required this.otherUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(otherUser.name ?? "Chat"),
      ),
      body: Center(
        child: Text("Chat with ${otherUser.name}"),
      ),
    );
  }
}
