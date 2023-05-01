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
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Color.fromARGB(255, 44, 41, 41),
                  leading: Center(
                    child: Image.asset(
                      "assets/images/madebyzomr.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  leadingWidth: 90,
                  title: Center(
                    child: Image.asset(
                      "assets/images/ZiiQue-Logo.png",
                      fit: BoxFit.cover,
                      scale: 10,
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 44, 41, 41)
                      ),
                      child: Image.asset(
                        "assets/images/menu-icon.png",
                      ),
                    ),
                  ],
                ),
                Container(),
              ],
            ),
          )),
    );
  }
}
