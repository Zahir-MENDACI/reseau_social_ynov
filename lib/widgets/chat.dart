import 'dart:ui';
import 'Dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reseau_social_ynov/functions/firebase_helper.dart';
import 'package:reseau_social_ynov/models/message.dart';

class Chats extends StatelessWidget {
  String chatId;

  Chats({required this.chatId});

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    // Stream<QuerySnapshot> getData() {
    //   Stream<QuerySnapshot> stream1 = FirebaseFirestore.instance
    //       .collection('chats')
    //       .where("idReceiver", isEqualTo: userReceiver.id)
    //       .where("idSender", isEqualTo: currentUser!.uid)
    //       .orderBy('createdAt', descending: false)
    //       .limit(15)
    //       .snapshots();
    //   Stream<QuerySnapshot> stream2 = FirebaseFirestore.instance
    //       .collection('chats')
    //       .where("idSender", isEqualTo: userReceiver.id)
    //       .where("idReceiver", isEqualTo: currentUser.uid)
    //       .orderBy('createdAt', descending: false)
    //       .limit(15)
    //       .snapshots();
    //       print("stream2: $stream2");
    //   return StreamGroup.merge([stream1, stream2]).asBroadcastStream();
    // }

    final Stream<QuerySnapshot> _chatsStream =
        FirebaseHelper().getMessages(chatId) as Stream<QuerySnapshot>;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseHelper().getMessages(chatId),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('$snapshot.error'));
        }
        if (!snapshot.hasData) {
          return Text('No data');
        } else {
          return Flexible(
            // Flexible prevents overflow error when keyboard is opened
            child: GestureDetector(
              // Close the keyboard if anything else is tapped
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: snapshot.data!.docs.map(
                  (DocumentSnapshot doc) {
                    Map<String, dynamic> data =
                        doc.data()! as Map<String, dynamic>;
                    Message message = Message(doc);
                    if (user!.uid == data['senderId']) {
                      return SentMessage(data: message);
                    } else {
                      return ReceivedMessage(data: message);
                    }
                  },
                ).toList(),
              ),
            ),
          );
        }
      },
    );
  }
}

class SentMessage extends StatelessWidget {
  const SentMessage({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Message data;

  @override
  Widget build(BuildContext context) {
    print("sender: $data");
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(), // Dynamic width spacer
          Container(
            constraints: BoxConstraints(
              maxWidth: 310.0,
            ),
            padding: const EdgeInsets.only(
              left: 10.0,
              top: 5.0,
              bottom: 5.0,
              right: 5.0,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.blueAccent,
                ],
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(40),
              ),
            ),
            child: GestureDetector(
                child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        data.message,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    // CircleAvatar(
                    //   radius: 20,
                    //   backgroundImage: NetworkImage(
                    //     data['imageUrl'],
                    //   ),
                    // ),
                  ],
                ),
                Text(data.createdAt.toString().substring(11, 16),
                    textAlign: TextAlign.right)
              ],
            )),
          ),
        ],
      ),
    );
  }
}

class ReceivedMessage extends StatelessWidget {
  const ReceivedMessage({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Message data;

  @override
  Widget build(BuildContext context) {
    print("receiver: $data");
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              constraints: BoxConstraints(
                maxWidth: 310.0,
              ),
              padding: const EdgeInsets.only(
                left: 5.0,
                top: 5.0,
                bottom: 5.0,
                right: 10.0,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueGrey, Colors.blueGrey],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // CircleAvatar(
                      //   radius: 20,
                      //   backgroundImage: NetworkImage(
                      //     data['imageUrl'],
                      //   ),
                      // ),
                      const SizedBox(width: 10.0),
                      Flexible(
                        child: Text(
                          data.message,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(data.createdAt.toString().substring(11, 16),
                      textAlign: TextAlign.right)
                ],
              )),
          const SizedBox(), // Dynamic width spacer
        ],
      ),
    );
  }
}