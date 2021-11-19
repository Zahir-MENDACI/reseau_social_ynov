import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:reseau_social_ynov/chat_page.dart';
import 'package:reseau_social_ynov/functions/firebase_helper.dart';
import 'package:reseau_social_ynov/inscription.dart';
import 'package:reseau_social_ynov/main.dart';
import 'package:reseau_social_ynov/models/utilisateur.dart';
import 'package:reseau_social_ynov/profil_page.dart';

class MapsPage extends StatefulWidget {
  @override
  State<MapsPage> createState() => MapsPageState();
}

class MapsPageState extends State<MapsPage> {
  late Geolocator geolocator;

  late Position maPosition;

  late List datas;

  Set<Marker> markers = {};

  // Stream usersDatas = FirebaseHelper().firestoreUsers.snapshots().listen((event) {

  // });

  @override
  void initState() {
    super.initState();
    Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.low)
        .listen((event) {
      maPosition = event;
      print("------------------------------$maPosition");
      monument = CameraPosition(
          target: LatLng(maPosition.latitude, maPosition.longitude), zoom: 15);
    });
  }

  void onMapCreated(GoogleMapController controller) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? currentUser = auth.currentUser;

    FirebaseHelper().firestoreUsers.get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print("-------------${result.data()}");
        Utilisateur user = Utilisateur(result);
        setState(() {
          markers.add(Marker(
            markerId: MarkerId(result.id),
            position: LatLng(user.position.latitude, user.position.longitude),
            infoWindow: InfoWindow(
                title: (currentUser!.uid == user.id)
                    ? "Vous etes ici"
                    : "${user.nom} ${user.prenom}",
                snippet: user.email,
                onTap: () async {
                  // if (currentUser.uid == user.id) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfilPage(user: user)),
                  );
                  // } else {
                  //   var chatId = FirebaseHelper()
                  //       .createChat(currentUser.uid, user.id)
                  //       .then((value) {
                  //         print("////------$value");
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => ChatPage(chatId: value)),
                  //         );
                  //       }).catchError((onError) {
                  //         print("Error");
                  //       });
                  // }
                }),
          ));
        });
      });
    });

    setState(() {
      markers.add(Marker(
        markerId: MarkerId('idtest'),
        position: LatLng(48.90270584779354, 2.205645341450424),
        infoWindow: InfoWindow(
            title: "test",
            snippet: "testttt",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Inscription()),
              );
            }),
      ));
      markers.add(Marker(
        markerId: MarkerId('idtest2'),
        position: LatLng(48.90175526973908, 2.2053522441749096),
        infoWindow: InfoWindow(
            title: "test3",
            snippet: "testttt2",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Inscription()),
              );
            }),
      ));
    });
  }

  CameraPosition monument = CameraPosition(
      target: LatLng(48.901925969588696, 2.2080655749616493), zoom: 15);

  Completer<GoogleMapController> controllerMap = Completer();
  late GoogleMapController test;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                    );
                  },
                  child: Text("LogOut"))
            ],
          ),
        ),
        body: GoogleMap(
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            initialCameraPosition: monument,
            markers: markers,
            onMapCreated: onMapCreated));
  }
}
