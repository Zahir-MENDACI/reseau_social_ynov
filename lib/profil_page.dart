// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reseau_social_ynov/chat_page.dart';
import 'package:reseau_social_ynov/functions/firebase_helper.dart';
import 'package:reseau_social_ynov/models/utilisateur.dart';

class ProfilPage extends StatefulWidget {
  Utilisateur user;

  ProfilPage({required Utilisateur this.user});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProfilPageState();
  }
}

class ProfilPageState extends State<ProfilPage> {
  @override
  void initState() {
    super.initState();
  }

  int nbLikes = 0;

  bool liked = false;

  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: bodyPage());
    // TODO: implement build
  }

  Widget bodyPage() {
    print("----------//${getLikes(widget.user.id)}");
    return SingleChildScrollView(
        child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseHelper().getLikes(widget.user.id),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              List likes = [];
              if (snapshot.hasData) {
                likes = snapshot.data!["likes"] as List;
              }
              // return Column(
              //   children: [
              //     Text(widget.user.email),
              //     IconButton(
              //       onPressed: (){
              //         if (likes.contains(currentUser!.uid)){
              //           FirebaseHelper().deleteLike(currentUser!.uid, widget.user.id);
              //         } else {
              //           FirebaseHelper().addLike(currentUser!.uid, widget.user.id);
              //         }
              //       },
              //       icon: likes.contains(currentUser!.uid) ? Icon(Icons.favorite) : Icon(Icons.favorite_border)
              //       ),
              //       Text(likes.length.toString())
              //       // Text(data)
              //   ],
              // );
              return Column(
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.blueGrey, Colors.lightBlue])),
                      child: Container(
                        width: double.infinity,
                        height: 350.0,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage(snapshot.data!["image"]),
                                radius: 50.0,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    snapshot.data!["nom"],
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  snapshot.data!["isMan"] ? Icon(Icons.male, color: Colors.white) : Icon(Icons.female, color: Colors.white)
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Card(
                                color: Colors.transparent,
                                elevation: 0.0,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0.0, vertical: 2.0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            IconButton(
                                                onPressed: () {
                                                  if (currentUser!.uid == widget.user.id)
                                                  {
                                                    null;
                                                  } else {
                                                    if (likes.contains(
                                                        currentUser!.uid)) {
                                                      FirebaseHelper().deleteLike(
                                                          currentUser!.uid,
                                                          widget.user.id);
                                                    } else {
                                                      FirebaseHelper().addLike(
                                                          currentUser!.uid,
                                                          widget.user.id);
                                                    }
                                                  }
                                                },
                                                icon: likes.contains(
                                                        currentUser!.uid)
                                                    ? Icon(Icons.favorite, color: Colors.redAccent,)
                                                    : Icon(
                                                        Icons.favorite_border, color: Colors.white,)),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(likes.length.toString())
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            IconButton(
                                                onPressed: () {
                                                  var chatId = FirebaseHelper()
                                                    .createChat(currentUser!.uid, widget.user.id)
                                                    .then((value) {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => ChatPage(chatId: value)),
                                                      );
                                                    }).catchError((onError) {
                                                      print("Error");
                                                    });
                                                },
                                                icon: currentUser!.uid !=
                                                        widget.user.id
                                                    ? Icon(Icons.chat_sharp, color: Colors.greenAccent)
                                                    : Container()),
                                            currentUser!.uid != widget.user.id ?  SizedBox(height: 5.0) : Container()
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30.0, horizontal: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Nom: ",
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 15.0),
                              ),
                              SizedBox(
                                height: 2.0,
                              ),
                              Text(
                                snapshot.data!["nom"],
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Prenom: ",
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 15.0),
                              ),
                              SizedBox(
                                height: 2.0,
                              ),
                              Text(
                                snapshot.data!["prenom"],
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Email: ",
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 15.0),
                              ),
                              SizedBox(
                                height: 2.0,
                              ),
                              Text(
                                snapshot.data!["email"],
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Date de naissance: ",
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 15.0),
                              ),
                              SizedBox(
                                height: 2.0,
                              ),
                              Text(
                                snapshot.data!["date"],
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            }));
  }
}

checkIfLiked(List likes, String id) {
  likes.contains(id);
}

getLikes(String id) async {
  var snapshot =
      FirebaseFirestore.instance.collection("utilisateurs").doc(id).snapshots();
}
