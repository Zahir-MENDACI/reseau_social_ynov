import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Chat{
  late List<String> ids;
  late DateTime createdAt;


  Chat(DocumentSnapshot snapshot) {
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    ids = map["ids"];
    createdAt = map["createdAt"];
  }
}