import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Message {
  late String chatId;
  late String message;
  late String senderId;
  late DateTime createdAt;

  Message(DocumentSnapshot snapshot) {
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    chatId = map["chatId"];
    message = map["message"];
    senderId = map["senderId"];
    createdAt = ( map['createdAt'] as Timestamp).toDate();
  }
}
