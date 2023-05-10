import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ziique/Custom%20Widgets/beatboard.dart';
import 'package:ziique/FireService/Fire_AuthService.dart';
import 'package:ziique/SoundEngine.dart';
import 'package:ziique/login-create/Create-Widget.dart';
import 'package:ziique/login-create/Login-Widget.dart';

import '../Settings/Settings-Widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

Color beatInfo = const Color.fromARGB(255, 72, 72, 72);
Color beatNorm = const Color.fromARGB(255, 0, 178, 255);
List<int> test = [1, 2, 3, 4];
List<int> beat = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17];

class BeatBoardApp extends StatelessWidget {
  BeatBoardApp(BuildContext context);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 44, 41, 41),
        leading: Center(
          child: Image.asset(
            "assets/images/madebyzomr.png",
            fit: BoxFit.cover,
          ),
        ),
        leadingWidth: 45,
        title: Center(
          child: Image.asset(
            "assets/images/ZiiQue-Logo.png",
            fit: BoxFit.cover,
            scale: 10,
          ),
        ),
        actions: [],
      ),
      endDrawer: Container(
        width: 450,
        child: Drawer(
          backgroundColor: Color.fromARGB(255, 44, 41, 41),
          child: ListView(
            children: <Widget>[
              if (FirebaseAuth.instance.currentUser != null) ...[
                SizedBox(
                  height: 64,
                  child: DrawerHeader(
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 8.0,
                          left: 4.0,
                          child: Text(
                            "YOUR BEATS",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 44, 41, 41),
                    ),
                  ),
                ),
                for (var i in test)
                  ListTile(
                    title: Text(i.toString()),
                    tileColor: Color.fromARGB(255, 217, 217, 217),
                  ),
                Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: SizedBox(
                          width: 290,
                          height: 60,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SettingsPageMobile(context)));
                            },
                            child: Text("Account Settings",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: SizedBox(
                          width: 290,
                          height: 60,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SettingsPageMobile(context)));
                            },
                            child: Text(
                              "Log Out",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ] else ...[
                Column(
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    Align(
                      child: Text(
                        "It seems you are not logged in",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      alignment: Alignment.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      child: SizedBox(
                        height: 40,
                        width: 200,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 77, 77, 77)),
                          onPressed: () {
                            if (kIsWeb) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CreateDesktop(context)));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CreateMobile(context)));
                            }
                          },
                          child: Text(
                            "Create Account",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Align(
                      child: Text(
                        "Already have an account?",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      alignment: Alignment.center,
                    ),
                    Align(
                      child: SizedBox(
                        height: 40,
                        width: 100,
                        child: TextButton(
                          onPressed: () {
                            if (kIsWeb) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          LoginDesktop(context)));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          LoginMobile(context)));
                            }
                          },
                          child: Text(
                            "Log in",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 25),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SettingsPageMobile(context)));
                      },
                      child: Text("Account Settings",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/grey-background.png"),
              fit: BoxFit.none,
            ),
          ),
          child: Column(
            children: [
              ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(5.0),
                children: [
                  BeatBoard(
                    playBarWidth: 160,
                    playBarColor: Color.fromARGB(255, 81, 81, 81),
                    playBarRounding: 5, 
                    playBarButtonSize: 45, 
                    playBarFontSize: 6, 
                    playBarOffset: 739, 
                    numberOfBeatButtons: beat, 
                    beatButtonBackColor: Color.fromARGB(255, 42, 42, 42), 
                    beatButtonSize: 45, 
                    beatButtonSampleColor: beatInfo, 
                    beatButtonNormColor: beatNorm, 
                    sampleFunction: (){
                      SoundEngine().playSingleSound("D");
                    }, 
                    normFunction: (){
                      SoundEngine().playSingleSound("D");
                    })
                ]
              ),
            ],
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
      appBar: AppBar(
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
        actions: [],
      ),
      endDrawer: Container(
        width: 450,
        child: Drawer(
          backgroundColor: Color.fromARGB(255, 44, 41, 41),
          child: ListView(
            children: <Widget>[
              if (FirebaseAuth.instance.currentUser != null) ...[
                SizedBox(
                  height: 64,
                  child: DrawerHeader(
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 8.0,
                          left: 4.0,
                          child: Text(
                            "YOUR BEATS",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 44, 41, 41),
                    ),
                  ),
                ),
                for (var i in test)
                  ListTile(
                    title: Text(i.toString()),
                    tileColor: Color.fromARGB(255, 217, 217, 217),
                  ),
                Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: SizedBox(
                          width: 290,
                          height: 60,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SettingsPageMobile(context)));
                            },
                            child: Text("Account Settings",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: SizedBox(
                          width: 290,
                          height: 60,
                          child: OutlinedButton(
                            onPressed: () {
                              SignOutService().SignOut();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BeatBoardDesktop(context)));
                            },
                            child: Text(
                              "Log Out",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ] else ...[
                Column(
                  children: [
                    SizedBox(
                      height: 360,
                    ),
                    Align(
                      child: Text(
                        "It seems you are not logged in",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      alignment: Alignment.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      child: SizedBox(
                        height: 40,
                        width: 200,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 77, 77, 77)),
                          onPressed: () {
                            if (kIsWeb) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CreateDesktop(context)));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CreateMobile(context)));
                            }
                          },
                          child: Text(
                            "Create Account",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Align(
                      child: Text(
                        "Already have an account?",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      alignment: Alignment.center,
                    ),
                    Align(
                      child: SizedBox(
                        height: 40,
                        width: 100,
                        child: TextButton(
                          onPressed: () {
                            if (kIsWeb) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          LoginDesktop(context)));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          LoginMobile(context)));
                            }
                          },
                          child: Text(
                            "Log in",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 25),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SettingsPageMobile(context)));
                      },
                      child: Text("Account Settings",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/grey-background.png"),
              fit: BoxFit.none,
            ),
          ),
          child: Column(
            children: [
              ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(20.0),
                children: [
                  BeatBoard(
                    playBarWidth: 200,
                    playBarColor: Color.fromARGB(255, 81, 81, 81),
                    playBarRounding: 10, 
                    playBarButtonSize: 65, 
                    playBarFontSize: 10, 
                    playBarOffset: 1175, 
                    numberOfBeatButtons: beat, 
                    beatButtonBackColor: Color.fromARGB(255, 42, 42, 42), 
                    beatButtonSize: 65, 
                    beatButtonSampleColor: beatInfo, 
                    beatButtonNormColor: beatNorm, 
                    sampleFunction: (){
                      SoundEngine().playSingleSound("D");
                    }, 
                    normFunction: (){
                      SoundEngine().playSingleSound("D");
                    })
                ],
              ),
            ],
          )),
    );
  }
}
