import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ziique/CustomWidgets/custom_drawer.dart';
import 'package:ziique/login-create/create_widget.dart';
import 'package:ziique/login-create/login_widget.dart';
import 'package:ziique/sound_engine.dart';
import '../Settings/settings_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/beat.dart';
import 'beat_board_widget.dart';

Color beatInfo = const Color.fromARGB(255, 72, 72, 72);
Color beatNorm = const Color.fromARGB(255, 0, 178, 255);
Color beatNormPress = const Color.fromARGB(255, 0, 105, 147);
int numberOfRows = 5;
int numberOfBars = 4;
int maxRange = (numberOfBars * 4);
int minRange = 1;
LoadBeat _loadBeat = LoadBeat();

class BeatBoardApp extends StatefulWidget {
  const BeatBoardApp(BuildContext context, {super.key});

  @override
  State<BeatBoardApp> createState() => _BeatBoardAppState();
}

class _BeatBoardAppState extends State<BeatBoardApp> {
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 2),
        () => 'Data Loaded',
  );

  void loadBeat(String beatString){
    print("TEST");
    print(boolList);
    boolList = _loadBeat.loadBeat(soundEngine, boolList);
    soundEngine.beatString = beatString;
    print(boolList);
  }

  Color beatInfo = const Color.fromARGB(255, 72, 72, 72);

  Color beatNorm = const Color.fromARGB(255, 0, 178, 255);

  Color beatNormPress = const Color.fromARGB(255, 0, 105, 147);

  List<bool> boolList =
  List.generate(numberOfRows * ((numberOfBars * 4) + 1), (index) => false);

  Alpha alpha = Alpha();

  @override
  Widget build(BuildContext context) {
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
        beatBoardDesktop: BeatBoardDesktop(context),
        soundEngine: SoundEngine(),
        onLoadBeat: loadBeat,
      ),
      body:  Column(
        children: [
          Center(
            child: Container(),
          ),
          FutureBuilder(
            future: _calculation,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: GridView.count(
                    padding: const EdgeInsets.all(8),
                    crossAxisCount: (numberOfBars * 4) + 1,
                    children: [
                      for (var i = 0;
                      i < ((numberOfBars * 4) + 1) * numberOfRows;
                      i++)
                        Container(
                          color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                  (alpha.calcGreenBut(i, numberOfBars) ==
                                      0)
                                      ? Colors.green
                                      : BeatColor(bar: numberOfBars)
                                      .getColor(i)
                                      ? (boolList[i] == true)
                                      ? Colors.grey[900]
                                      : Colors.grey
                                      : (boolList[i] == true)
                                      ? Colors.grey[900]
                                      : Colors.blueGrey),
                              onPressed: () {
                                setState(() {
                                  boolList[i] = !boolList[i];
                                  maxRange = (numberOfBars * 4);
                                  minRange = 1;
                                });
                              },
                              child: Text(
                                alpha.getAlphebat(i, numberOfBars),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              } else {
                return const SizedBox(
                  height: 200,
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
class Alpha {
  Alpha() {
    for (int i = 65; i <= 90; i++) {
      alphabets.add(String.fromCharCode(i));
    }
  }

  int greenBut = 0;
  List<String> alphabets = [];

  int calcGreenBut(i, numberOfBars) {
    greenBut = i % ((numberOfBars * 4) + 1);
    return greenBut;
  }

  String getAlphebat(i, numberOfBars) {
    if (greenBut == 0) {
      return alphabets[i == 1 ? 1 : i ~/ ((numberOfBars * 4) + 1)];
    }
    return i.toString();
  }
}

class LoadBeat {
  LoadBeat();

  List<int> nodes = [];

  List<bool> loadBeat(SoundEngine soundEngine, List<bool> bools) {
    bools.every((element) => false);
    nodes = soundEngine.nodeInt(numberOfBars);
    for (var node in nodes) {
      bools[node] = true;
    }
    print(bools);
    return bools;
  }
}

class BeatColor {
  BeatColor({required this.bar});

  final int bar;

  bool getColor(int i) {
    if (kDebugMode) {
      print(
          "beatIndex: $i maxRange: $maxRange${i == maxRange ? " true" : " false"}");
    }
    if (i == maxRange) {
      maxRange += (numberOfBars * 4) + 1;
      minRange += (numberOfBars * 4) + 1;
      maxRange += (numberOfBars * 4) + 1;
      minRange += (numberOfBars * 4) + 1;
      return true;
    } else if (i >= minRange && i <= maxRange) {
      return true;
    } else {
      return false;
    }
  }
}