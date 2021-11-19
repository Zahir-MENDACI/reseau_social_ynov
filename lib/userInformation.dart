import 'package:flutter/material.dart';
import 'package:reseau_social_ynov/functions/firebase_helper.dart';
import 'package:reseau_social_ynov/models/utilisateur.dart';
import 'package:reseau_social_ynov/profilPage.dart';

class userInformation extends StatefulWidget{


  String prenom;
  userInformation({required String this.prenom,String? nom});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return userInformationState();
  }

}


class userInformationState extends State<userInformation>{
  String nom='';
  String pseudo='';
  String prenom='';
  String adresse='';
  bool jeuxvideo = false;
  bool lecture=false;
  bool sport=false;
  bool reseauxSociaux=false;
  bool isMan=true;
  List loisirs=[];
  String identifiant='';

  late Utilisateur user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //identifiant = FirebaseHelper().instanceStorage;

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Mes informations"),
      ),
      body: bodyPage(),
    );
  }



  Widget bodyPage(){
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(

        children: [
          //sexe
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Femme'),
              Switch.adaptive(
                  value: isMan,
                  onChanged: (bool value){
                    setState(() {
                      isMan = value;
                    });
                  }
              ),
              Text('Homme')

            ],
          ),

          //nom
          TextField(
            onChanged: (String value){
              setState(() {
                nom = value;


              });
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),

                ),
                fillColor: Colors.white,
                filled: true,
                hintText: "Nom"
            ),

          ),
          SizedBox(height: 20,),
          //prenom
          TextField(
            onChanged: (String value){
              setState(() {
                prenom = value;


              });
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),

                ),
                fillColor: Colors.white,
                filled: true,
                hintText: "Prenom"
            ),

          ),
          SizedBox(height: 20,),
          //pseudo
          TextField(
            onChanged: (String value){
              setState(() {
                pseudo = value;


              });
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),

                ),
                fillColor: Colors.white,
                filled: true,
                hintText: "Pseudo"
            ),

          ),
          //adresse
          SizedBox(height: 20,),
          TextField(
            onChanged: (String value){
              setState(() {
                adresse = value;


              });
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),

                ),
                fillColor: Colors.white,
                filled: true,
                hintText: "Adresse"
            ),

          ),
          SizedBox(height: 20,),


          CheckboxListTile(
            title: Text('Jeux vidéos'),
            onChanged: (bool? value){
              setState(() {
                jeuxvideo = value!;
              });
            },
            value: jeuxvideo,


          ),
          CheckboxListTile(
            title: Text('lecture'),
            onChanged: (bool? value){
              setState(() {
                lecture = value!;
              });
            },
            value: lecture,


          ),
          CheckboxListTile(
            title: Text('sport'),
            onChanged: (bool? value){
              setState(() {
                sport = value!;
              });
            },
            value: sport,


          ),
          CheckboxListTile(
            title: Text('Réseaux sociaux'),
            onChanged: (bool? value){
              setState(() {
                reseauxSociaux = value!;
              });
            },
            value: reseauxSociaux,


          ),

          ElevatedButton(



              onPressed: (){
                //création de la liste

                ajouterliste(jeuxvideo,loisirs,"Jeux Videos");
                ajouterliste(sport,loisirs,"Sport");
                ajouterliste(reseauxSociaux,loisirs,"Réseaux sociaux");
                ajouterliste(lecture,loisirs,"lecture");

                //créattion de la map
                Map<String,dynamic> map ={
                  "nom":nom,
                  "prenom":prenom,
                  "adresse":adresse,
                  "isMan":isMan,
                  "loisirs":loisirs
                };

                //Enregistrement dans la base du donnée
                FirebaseHelper().addUser(map, identifiant);

                Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context){
                      return ProfilPage();
                    }
                ));

              },
              child: Text('Enregistrer')
          ),

        ],
      ),
    );


  }
  List ajouterliste(bool element, List list, String valeur){
    if(element){
      list.add(valeur);
    }

    return  list;

  }

}