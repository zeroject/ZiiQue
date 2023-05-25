import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ziique/BeatBoard/beat_board_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ziique/BeatBoard/beat_board_app_widget.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';

void main() async {
  String host = "";
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.web,
    );
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }
  if (!kReleaseMode){
    if (kIsWeb){
      host = "localhost";
      FirebaseFirestore.instance.useFirestoreEmulator(host, 8000, sslEnabled: false);
      FirebaseAuth.instance.useAuthEmulator(host, 9099);
      FirebaseStorage.instance.useStorageEmulator(host, 9199);
      FirebaseDatabase.instance.useDatabaseEmulator(host, 9000);
      FirebaseFunctions.instance.useFunctionsEmulator(host, 5001);
    }
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
          else {
            return BeatBoardApp(context);
          }
        },
      ),
    );
  }
}
