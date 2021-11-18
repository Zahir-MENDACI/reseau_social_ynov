import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:reseau_social_ynov/functions/firebase_helper.dart';
import 'package:reseau_social_ynov/inscription.dart';


class ProfilPage extends StatefulWidget {


  @override
  State<ProfilPage> createState() => ProfilPageState();
}

class ProfilPageState extends State<ProfilPage> {

  final double coverHeight = 280;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Page de profil"),
        ),
        body: buildCoverImage(),

    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
  
  Widget buildCoverImage() => Container(
    width: double.infinity,
    height: coverHeight,
    decoration: BoxDecoration(
      image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage('https://images.unsplash.com/photo-1591280063444-d3c514eb6e13?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80'))
    ),
  );
}
