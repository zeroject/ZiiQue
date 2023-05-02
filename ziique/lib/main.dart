import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ziique/BeatBoard/BeatBoard-Widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ziique/Settings/Settings-Widget.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';

void main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    return const MaterialApp(
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
      appBar: AppBar(
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SettingsPageMobile(context)));
              },
              child: Text("Settings")),
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (Platform.isAndroid) {
            return BeatBoardApp(context);
          } else {
            return BeatBoardDesktop(context);
          }
        },
      ),
    );
  }
}
