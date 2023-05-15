import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ziique/CustomWidgets/customdrawer.dart';
import 'package:ziique/login-create/create_widget.dart';
import 'package:ziique/login-create/login_widget.dart';
import '../Settings/settings_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

Color beatInfo = const Color.fromARGB(255, 72, 72, 72);
Color beatNorm = const Color.fromARGB(255, 0, 178, 255);
Color beatNormPress = const Color.fromARGB(255, 0, 105, 147);
List<int> test = [1, 2, 3, 4];
List<bool> _bools = List.generate(numberOfRows * ((numberOfBars * 4) + 1), (index) => false);
int numberOfRows = 8;
int numberOfBars = 4;
int maxRange = (numberOfBars * 4);
int minRange = 1;

class BeatBoardApp extends StatelessWidget {
  const BeatBoardApp(BuildContext context, {super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 44, 41, 41),
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
        actions: const [],
      ),
      endDrawer: CustomDrawer(
        drawerWidth: 450,
        backgroundColor: const Color.fromARGB(255, 44, 41, 41),
        firebaseAuthUser: FirebaseAuth.instance.currentUser != null,
        drawerHeadHeight: 64,
        beatList: const [1, 2],
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
                  children: const [
                  ]),
            ],
          )),
    );
  }
}