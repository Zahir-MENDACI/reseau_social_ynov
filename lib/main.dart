import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:reseau_social_ynov/functions/firebaseHelper.dart';
import 'package:reseau_social_ynov/inscription.dart';
import 'package:reseau_social_ynov/mapsPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  User? user = FirebaseAuth.instance.currentUser;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user != null ? "connecté" : ""),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                      FirebaseHelper().connexion(emailController.text, passwordController.text)
                          .then((value) {
                            print(value.user.email);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("${value.user.email} Connecté"),
                              duration: const Duration(milliseconds: 2000),
                              width: 300.0,
                              // Width of the SnackBar.
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 8.0, // Inner padding for SnackBar content.
                              ),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            )
                        );
                      }
                      ).catchError((e){
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
                      });


                    setState(() {

                    });
                  },
                  child: Text("Se connecter")
              ),
              ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    setState(() {

                    });
                  },
                  child: Text("Deconnecter")
              ),
              ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Inscription()),
                    );
                    setState(() {

                    });
                  },
                  child: Text("S'inscrire")),
              ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MapsPage()),
                    );
                    setState(() {

                    });
                  },
                  child: Text("maps page"))

            ],
          )
      ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
