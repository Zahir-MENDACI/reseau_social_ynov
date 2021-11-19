import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:reseau_social_ynov/functions/firebase_helper.dart';

class Inscription extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return InscriptionState();
  }
}

class InscriptionState extends State<Inscription> {
  bool isMan = true;

  final nomController = TextEditingController();
  final prenomController = TextEditingController();
  final dateController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late Uint8List imageBytes;
  String imageName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User"),
      ),
      body: Center(
          child: Column(
        children: [
          Container(
            width: 300,
            child: TextField(
              controller: nomController,
              decoration: InputDecoration(hintText: "Nom"),
            ),
          ),
          Container(
            width: 300,
            child: TextField(
              controller: prenomController,
              decoration: InputDecoration(hintText: "Prenom"),
            ),
          ),
          Container(
            width: 300,
            child: TextField(
              controller: dateController,
              decoration: InputDecoration(hintText: "Date de naissance"),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Femme'),
              Switch.adaptive(
                  value: isMan,
                  onChanged: (bool value) {
                    setState(() {
                      isMan = value;
                    });
                  }),
              Text('Homme')
            ],
          ),
          Container(
            width: 300,
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(hintText: "Email"),
            ),
          ),
          Container(
            width: 300,
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(hintText: "Password"),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                try {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    withData: true,
                    type: FileType.image,
                  );
                  if (result != null) {
                    setState(() {
                      imageBytes = result.files.first.bytes!;
                      imageName = result.files.first.name;
                    });
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: Text('Photo de profil')),
          ElevatedButton(
              onPressed: () async {
                Map<String, dynamic> map = {
                  "nom": nomController.text,
                  "prenom": prenomController.text,
                  "date": dateController.text,
                  "isMan": isMan,
                  "email": emailController.text,
                  "password": passwordController.text,
                  'imageBytes': imageBytes,
                  "imageName": imageName
                };

                final authResult =
                    FirebaseHelper().inscription(map).then((value) {
                  Navigator.pop(context);
                }).catchError((e) {
                  print(e);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.toString()),
                      duration: const Duration(milliseconds: 2000),
                      width: 300.0, // Width of the SnackBar.
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 8.0, // Inner padding for SnackBar content.
                      ),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  );
                });

                setState(() {});
              },
              child: Text("S'inscrire")),
        ],
      )),
    );
  }
}
