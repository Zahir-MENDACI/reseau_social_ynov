import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:reseau_social_ynov/functions/firebaseHelper.dart';

class Inscription extends StatefulWidget {



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return InscriptionState();
  }
}

class InscriptionState extends State<Inscription> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: "Email"
                  ),
                ),
              ),
              Container(
                width: 300,
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Password"
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                      final authResult = FirebaseHelper().inscription(emailController.text, passwordController.text)
                          .then((value) {
                        Navigator.pop(context);
                      }).catchError((e){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.toString()),
                            duration: const Duration(milliseconds: 2000),
                            width: 300.0, // Width of the SnackBar.
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 8.0,// Inner padding for SnackBar content.
                            ),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        );
                    }
                      );


                    setState(() {

                    });
                  },
                  child: Text("S'inscrire")
              ),
            ],
          )
      ),
    );
  }
}