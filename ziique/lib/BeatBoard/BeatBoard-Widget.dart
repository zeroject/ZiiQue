import 'package:flutter/material.dart';

class BeatBoardApp extends StatelessWidget {
  BeatBoardApp(BuildContext context);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/grey-background.png"),
                fit: BoxFit.none),
          ),
          child: Container(
            child: Row(
              children: [Text("APP")],
            ),
          )),
    );
  }
}

class BeatBoardDesktop extends StatelessWidget {
  BeatBoardDesktop(BuildContext context);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/grey-background.png"),
              fit: BoxFit.none,
            ),
          ),
          child: Container(
            child: Row(
              children: [Text("DESKTOP")],
            ),
          )),
    );
  }
}
