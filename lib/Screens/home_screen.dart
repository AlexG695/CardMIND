import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:singin/realtime_db/Post.dart';
import 'package:url_launcher/url_launcher.dart';

var currentIndex = 0;

//DatabaseReference? CarMIND;
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  CollectionReference coleccionLDR =
      FirebaseFirestore.instance.collection('sensor LDR');

  CollectionReference coleccionULTRA =
      FirebaseFirestore.instance.collection('sensor ULTRA');

  var currentIndex = 0;
  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.camera_rounded,
    Icons.settings_rounded,
    Icons.person_rounded,
  ];

  List<String> listOfStrings = [
    'Home',
    'Photos',
    'Settings',
    'Account',
  ];

  void callEmergency() {
    launch("tel://911");
  }

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estado'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                callEmergency();
              },
              icon: const Icon(Icons.perm_phone_msg_outlined)),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.car_rental_rounded),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              StreamBuilder(
                stream: coleccionLDR.doc("sh3C4XK69wRtO24Pg59Q").snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.data["Estado"] != null) {
                      return Text(
                          snapshot.data.data()["Estado"] ?? "Desactivado");
                    } else {
                      return const Text(
                          'No se detecta nada cerca del automovil');
                    }
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              StreamBuilder(
                stream: coleccionLDR.doc("sh3C4XK69wRtO24Pg59Q").snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.data["Mensaje"] != null) {
                      return Text(
                          snapshot.data.data()["Mensaje"] ?? "Puerta cerrada");
                    } else {
                      return const Text("La puerta está cerrada");
                    }
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              StreamBuilder(
                stream: coleccionULTRA.doc("676lC9BKFOLSivyA8wB3").snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.data["Estado"] != null) {
                      return Text(snapshot.data()["Estado"] ?? "Desactivado");
                    } else {
                      return const Text("Desactivado");
                    }
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              const Divider(
                indent: 30,
                endIndent: 30,
                color: Colors.grey,
              ),
              StreamBuilder(
                stream: coleccionULTRA.doc("676lC9BKFOLSivyA8wB3").snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.data["Mensaje"] != null) {
                      return Text(snapshot.data.data()["Mensaje"] ??
                          "No hay objetos cercanos");
                    } else {
                      return const Text("No hay objetos cercanos");
                    }
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ),
      ),
      /*bottomNavigationBar: Container(
        margin: EdgeInsets.all(displayWidth * .05),
        height: displayWidth * .155,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: displayWidth * .02),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(() {
                currentIndex = index;
                HapticFeedback.lightImpact();
              });
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == currentIndex
                      ? displayWidth * .32
                      : displayWidth * .18,
                  alignment: Alignment.center,
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: index == currentIndex ? displayWidth * .12 : 0,
                    width: index == currentIndex ? displayWidth * .32 : 0,
                    decoration: BoxDecoration(
                      color: index == currentIndex
                          ? Colors.blueAccent.withOpacity(.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == currentIndex
                      ? displayWidth * .31
                      : displayWidth * .18,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width:
                                index == currentIndex ? displayWidth * .13 : 0,
                          ),
                          AnimatedOpacity(
                            opacity: index == currentIndex ? 1 : 0,
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: Text(
                              index == currentIndex
                                  ? '${listOfStrings[index]}'
                                  : '',
                              style: const TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width:
                                index == currentIndex ? displayWidth * .03 : 20,
                          ),
                          Icon(
                            listOfIcons[index],
                            size: displayWidth * .076,
                            color: index == currentIndex
                                ? Colors.blueAccent
                                : Colors.black26,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),*/
    );
  }

  void refresh() {
    setState(() {}); // CTRL + S
  }
}
