import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';

class FirebaseHelper {
  final authBase = FirebaseAuth.instance;
  final instanceFirestore = FirebaseFirestore.instance.collection("users");
  final instanceStorage = FirebaseStorage.instance;

  final firestoreUsers = FirebaseFirestore.instance.collection("utilisateurs");

//inscription

  Future inscription(Map<String, dynamic> map) async {
    final authResult = await authBase.createUserWithEmailAndPassword(
        email: map['email'].toString(), password: map['password'].toString());

    Position userPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final imageBytes = map["imageBytes"];
    final imageName = map["imageName"];

    map.remove("password");
    map.remove("imageBytes");
    map.remove("imageName");
    map['position'] =
        new GeoPoint(userPosition.latitude, userPosition.longitude);

    print("//////$map");
    var uploadImage;

    uploadImage = await instanceStorage.ref('users/profils/$imageName').putData(imageBytes)
    .then((image) async {
      await image.ref.getDownloadURL()
      .then((imageUrl) async {
        map['image'] = imageUrl;
        var query = FirebaseFirestore.instance
            .collection("utilisateurs")
            .doc(authResult.user!.uid);
        
        map['id'] = query.id;
        await query.set(map);
      });
    });
    


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

  
  Future createChat(String idA, String idB) async {
    List<String> ids = [idA, idB];
    ids.sort();
    final check = await FirebaseFirestore.instance.collection("chats").where("users", isEqualTo: ids).get();
    if (check.size > 0)
    {
      return check.docs[0].id;
    }
    else
    {
      final chat = await FirebaseFirestore.instance.collection("chats").add({
        "users": ids,
        "createdAt": DateTime.now()
        });
      return chat.id;
    }
  }

  createMessage(String idChat, String idSender, String message) async {
      final addMessage = await FirebaseFirestore.instance.collection("messages").add({
        "chatId": idChat,
        "senderId": idSender,
        "message": message,
        "createdAt": DateTime.now()
        });
      return addMessage;
    }

 getLikes(String id) {
     return FirebaseFirestore.instance.collection("utilisateurs").doc(id).snapshots(); 
  }

  addLike(String id, String idProfil) async {
      final addLike = await FirebaseFirestore.instance.collection("utilisateurs").doc(idProfil).update({"likes": FieldValue.arrayUnion([id]) });
      return addLike;
    }
  deleteLike(String id, String idProfil) async {
      final deleteLike = await FirebaseFirestore.instance.collection("utilisateurs").doc(idProfil).update({"likes": FieldValue.arrayRemove([id]) });
      return deleteLike;
    }

  Stream<QuerySnapshot> getMessages(String idChat) {
      return FirebaseFirestore.instance.collection("messages").where("chatId", isEqualTo: idChat).orderBy("createdAt", descending: false).snapshots();
    }




  // Future getChatId(String idA, String idB) async {
  //   final user = await FirebaseFirestore.instance.collection("chats").where("users", isEqualTo: ).get()
  //   .then((value) {
  //     value
  //   })
  //   user.
  // }

  addUser(Map<String, dynamic> map, String uid) {
    FirebaseFirestore.instance.collection("utilisateur").doc(uid).set(map);
  }

  // Future getUsersList() async {
  //   List usersList = [];

  //   try {
  //     await firestoreUsers.doc()
  //   } catch (e) {
  //   }
  // }

}
