import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseHelper {
  final authBase = FirebaseAuth.instance;
  final instanceFirestore = FirebaseFirestore.instance.collection("users");
  final instanceStorage = FirebaseStorage.instance;

//inscription

  Future inscription(String email, String password) async {
    final authResult = await authBase.createUserWithEmailAndPassword(
        email: email, password: password);

    final user = authResult.user;
    return user;
  }


//connexion
  Future connexion(String email, String password) async {
    final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    );
    return user;
  }
}
