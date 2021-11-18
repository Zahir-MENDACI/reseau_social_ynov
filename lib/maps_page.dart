import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:reseau_social_ynov/functions/firebase_helper.dart';
import 'package:reseau_social_ynov/inscription.dart';


class MapsPage extends StatefulWidget {


  @override
  State<MapsPage> createState() => MapsPageState();
}

class MapsPageState extends State<MapsPage> {

  late Geolocator geolocator;

  late Position maPosition;

  Set<Marker> markers = {};

    @override
  void initState() {
    super.initState();
    Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.low).listen((event) {
        maPosition = event;
        print("------------------------------$maPosition");
        monument = CameraPosition(
            target: LatLng(maPosition.latitude, maPosition.longitude),
            zoom: 15
        );
    });
  }



  void onMapCreated(GoogleMapController controller){
    setState(() {
      markers.add(
          Marker(
              markerId: MarkerId('idtest'),
              position: LatLng(48.90270584779354, 2.205645341450424),
              infoWindow: InfoWindow(
                  title: "test",
                  snippet: "testttt",
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Inscription()),
                    );
                  }
              ),
          )
      );
      markers.add(
          Marker(
            markerId: MarkerId('idtest2'),
            position: LatLng(48.90175526973908, 2.2053522441749096),
            infoWindow: InfoWindow(
                title: "test3",
                snippet: "testttt2",
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Inscription()),
                  );
                }
            ),
          )
      );
    });
  }


  

  CameraPosition monument = CameraPosition(
      target: LatLng(48.901925969588696, 2.2080655749616493),
      zoom: 15
  );

  Completer <GoogleMapController> controllerMap = Completer();
  late GoogleMapController test;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("title"),
        ),
        body: GoogleMap(
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          initialCameraPosition: monument,
          markers: markers,
          onMapCreated: onMapCreated
        )


        ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
