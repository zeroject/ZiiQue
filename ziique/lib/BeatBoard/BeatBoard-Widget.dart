import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:ziique/Custom%20Widgets/beatboard.dart';
import 'package:ziique/Custom%20Widgets/customdrawer.dart';
import 'package:ziique/FireService/Fire_AuthService.dart';
import 'package:ziique/SoundEngine.dart';
import 'package:ziique/login-create/Create-Widget.dart';
import 'package:ziique/login-create/Login-Widget.dart';

import '../FireService/Fire_BeatService.dart';
import '../Settings/Settings-Widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/beat.dart';

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
      endDrawer: CustomDrawer(
        drawerWidth: 450,
        backgroundColor: const Color.fromARGB(255, 44, 41, 41),
        firebaseAuthUser: FirebaseAuth.instance.currentUser != null,
        drawerHeadHeight: 64,
        beatList: [1, 2],
        settingsButHeight: 60,
        settingsButWidth: 290,
        settingsPageDesktop: SettingsPageMobile(context),
        settingsPageMobile: SettingsPageMobile(context),
        offsetHeight: 80,
        createAccButHeight: 40,
        createAccButWidth: 200,
        createButColor: const Color.fromARGB(255, 77, 77, 77),
        kIsWeb: kIsWeb,
        createPageDesktop: CreateDesktop(context),
        createPageMobile: CreateMobile(context),
        loginButHeight: 40,
        loginButWidth: 100,
        loginPageDesktop: LoginDesktop(context),
        loginPageMobile: LoginMobile(context),
      ),
      body: Container(
          decoration: const BoxDecoration(
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
                      childRowA: ElevatedButton(
                        onPressed: () {},
                        child: Text(""),
                      ),
                      childRowB: ElevatedButton(
                        onPressed: () {},
                        child: Text(""),
                      ),
                      childRowC: ElevatedButton(
                        onPressed: () {},
                        child: Text(""),
                      ),
                      childRowD: ElevatedButton(
                        onPressed: () {},
                        child: Text(""),
                      ),
                    ),
                  ]),
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
      endDrawer: CustomDrawer(
        drawerWidth: 450,
        backgroundColor: const Color.fromARGB(255, 44, 41, 41),
        firebaseAuthUser: FirebaseAuth.instance.currentUser != null,
        drawerHeadHeight: 64,
        beatList: [1, 2],
        settingsButHeight: 60,
        settingsButWidth: 290,
        settingsPageDesktop: SettingsPageMobile(context),
        settingsPageMobile: SettingsPageMobile(context),
        offsetHeight: 360,
        createAccButHeight: 40,
        createAccButWidth: 200,
        createButColor: const Color.fromARGB(255, 77, 77, 77),
        kIsWeb: kIsWeb,
        createPageDesktop: CreateDesktop(context),
        createPageMobile: CreateMobile(context),
        loginButHeight: 40,
        loginButWidth: 100,
        loginPageDesktop: LoginDesktop(context),
        loginPageMobile: LoginMobile(context),
      ),
      body: Container(
          decoration: const BoxDecoration(
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
                    childRowA: ElevatedButton(
                      onPressed: () {},
                      child: Text(""),
                    ),
                    childRowB: ElevatedButton(
                      onPressed: () {},
                      child: Text(""),
                    ),
                    childRowC: ElevatedButton(
                      onPressed: () {},
                      child: Text(""),
                    ),
                    childRowD: ElevatedButton(
                      onPressed: () {},
                      child: Text(""),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
