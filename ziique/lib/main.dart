import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ziique/BeatBoard/BeatBoard-Widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';
import 'FireService/Fire_BeatService.dart';
import 'FireService/Fire_AuthService.dart';

void main() async {
  String host = "";
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    host = "localhost";
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.web,
    );
  } else if(Platform.isAndroid){
    host = "10.0.2.2";
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  if (!kReleaseMode){
    FirebaseFirestore.instance.useFirestoreEmulator(host, 8000, sslEnabled: false);
    FirebaseAuth.instance.useAuthEmulator(host, 9099);
    FirebaseStorage.instance.useStorageEmulator(host, 9199);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ZiiQue',
      home: MyHomePage(title: 'ZiiQue'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (kIsWeb){
            return BeatBoardDesktop(context);
          }
          else if (Platform.isAndroid) {
            return BeatBoardApp(context);
          } else {
            return BeatBoardDesktop(context);
            
          }
        },
      ),
    );
  }
}
