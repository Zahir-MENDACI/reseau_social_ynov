import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Utilisateur{
  late String prenom;
  late String nom;
  late String email;
  late bool isMan;
  late DateTime dateNaissance;
  late String image;


  Utilisateur(DocumentSnapshot snapshot) {
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    prenom = map["prenom"];
    nom = map["nom"];
    email = map["email"];
    dateNaissance = map["dateNaissance"];
    isMan = map["isMan"];
    image = map["image"];
  }
}