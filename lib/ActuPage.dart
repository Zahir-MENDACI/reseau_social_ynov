import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:reseau_social_ynov/functions/firebase_helper.dart';

class ActuPage extends StatefulWidget {



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ActuPageState();
  }
}

class ActuPageState extends State<ActuPage> {


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("Fil d'actualité"),
      ),
      body: Text('Mes photos')  ,
    );
  }
}

