import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';

class FirebaseHelper {
  final authBase = FirebaseAuth.instance;
  final instanceFirestore = FirebaseFirestore.instance.collection("users");
  final instanceStorage = FirebaseStorage.instance;

  final firestoreUsers =FirebaseFirestore.instance.collection("utilisateurs");

//inscription

  Future inscription(Map<String, dynamic> map) async {
    final authResult = await authBase.createUserWithEmailAndPassword(
        email: map['email'].toString(), password: map['password'].toString());

    Position userPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    map.remove("password");
    map['position'] = new GeoPoint(userPosition.latitude, userPosition.longitude);

    print("//////$map");

    FirebaseFirestore.instance
        .collection("utilisateurs")
        .doc(authResult.user!.uid)
        .set(map);

    final user = authResult.user;
    print("---$user");
    // FirebaseFirestore.instance.collection("utilisateur").doc(uid).set(map);
    return user;
  }

//connexion
  Future connexion(String email, String password) async {
    final user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return user;
  }

  addUser(Map<String, dynamic> map, String uid) {
    FirebaseFirestore.instance.collection("utilisateur").doc(uid).set(map);
  }
}
