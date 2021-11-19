import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:reseau_social_ynov/functions/firebase_helper.dart';
import 'package:reseau_social_ynov/inscription.dart';
import 'package:reseau_social_ynov/main.dart';
import 'package:reseau_social_ynov/userInformation.dart';

import 'ActuPage.dart';


class ProfilPage extends StatefulWidget {


  @override
  State<ProfilPage> createState() => ProfilPageState();
}

class ProfilPageState extends State<ProfilPage> {

  final double coverHeight = 280;
  final double profileHeight = 144;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Page de profil"),
        ),
        body: ListView(
          padding: EdgeInsets.zero,
          children: <Widget> [
            buildTop(),
            buildContent(),
            buildButtonBar(),
          ],
        ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }

  Widget buildTop() {
    final bottom = profileHeight / 2;
    final top = coverHeight - profileHeight/2;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: buildCoverImage(),
        ),
        Positioned(
          top: top,
          child: buildProfileImage(),
        ),
      ],
    );
  }

  Widget buildContent() => Column(
     children: [
      const SizedBox(height: 8),
      Text(
        'Jolie Smith',
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      ),
       const SizedBox(height: 8),
       Text(
          'Flutter Software Engineer',
          style: TextStyle(fontSize: 20, color: Colors.black)
        ),
       const SizedBox(height: 30),
     ],
  );

  Widget buildCoverImage() => Container(
    width: double.infinity,
    height: coverHeight,
    decoration: BoxDecoration(
      color: Colors.grey,
      image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage('https://images.unsplash.com/photo-1591280063444-d3c514eb6e13?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80'))
    ),
  );

  Widget buildProfileImage() => CircleAvatar(
    radius: profileHeight / 2,
    backgroundColor: Colors.grey.shade800,
    backgroundImage: NetworkImage('https://images.unsplash.com/photo-1611417361507-7d77bbc20a73?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1887&q=80'
  ),
  );


  Widget buildButtonBar() => Row(
      children: [
        const SizedBox(width: 8),
        ElevatedButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => userInformation(prenom: 'Jolie')),
              );
            },
            child: Text("Mes informations")),
        const SizedBox(width: 8),
        ElevatedButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ActuPage()),
              );
            },
            child: Text("Ma fil d'actualité")),
        const SizedBox(width: 8),
        ElevatedButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ActuPage()),
              );
            },
            child: Text("Chat")),

      ],
    );


}
