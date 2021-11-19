import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reseau_social_ynov/widgets/chat.dart';
import 'package:reseau_social_ynov/widgets/message_input.dart';

class ChatPage extends StatefulWidget {
  String chatId;

  ChatPage({required this.chatId});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChatPageState();
  }
}

class ChatPageState extends State<ChatPage> {
  final messageController = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(""),
        ),
        body: Container(
          // padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // mainAxisSize: MainAxisSize.max,
            children: [
              Chats(chatId: widget.chatId),
              MessageInput(chatId: widget.chatId)
            ],
          ),
        ));
  }
}