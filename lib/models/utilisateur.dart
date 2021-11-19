import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Utilisateur{
  late String id;
  late String prenom;
  late String nom;
  late String email;
  late bool isMan;
  late GeoPoint position;
  // late DateTime dateNaissance;
  late String image;


  Utilisateur(DocumentSnapshot snapshot) {
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    id = map["id"];
    prenom = map["prenom"];
    nom = map["nom"];
    email = map["email"];
    // dateNaissance = map["dateNaissance"];
    isMan = map["isMan"];
    position = map["position"];
    image = map["image"];
  }
}