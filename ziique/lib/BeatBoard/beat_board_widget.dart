import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ziique/CustomWidgets/customdrawer.dart';
import 'package:ziique/FireService/fire_user_service.dart';
import 'package:ziique/login-create/create_widget.dart';
import 'package:ziique/login-create/login_widget.dart';
import 'package:ziique/sound_engine.dart';
import '../FireService/RealtimeData/fire_beatIt_realtime_service.dart';
import '../FireService/fire_beat_Service.dart';
import '../Settings/settings_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/getwidget.dart';
import '../models/Notifer.dart';
import '../models/user.dart' as beat_user;


int numberOfRows = 5;
int numberOfBars = 4;
int maxRange = (numberOfBars * 4);
int minRange = 1;
SoundEngine soundEngine = SoundEngine();
Notifer notifer = Notifer();
final Future<beat_user.User?> userquery = Future(() =>
    UserService().getUser(FirebaseAuth.instance.currentUser!.uid));
beat_user.User? beatuser;

class BeatBoardDesktop extends StatefulWidget {
  const BeatBoardDesktop(BuildContext context, {super.key});

  @override
  State<BeatBoardDesktop> createState() => _BeatBoardDesktopState();
}

class _BeatBoardDesktopState extends State<BeatBoardDesktop> {
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(milliseconds: 1200),
        () => 'Data Loaded',
  );

  Color beatInfo = const Color.fromARGB(255, 72, 72, 72);
  Color beatNorm = const Color.fromARGB(255, 0, 178, 255);
  Color beatNormPress = const Color.fromARGB(255, 0, 105, 147);
  List<bool> boolList =
  List.generate(numberOfRows * ((numberOfBars * 4) + 1), (index) => false);
  Alpha alpha = Alpha();
  FireBeatItRealtimeService fireBeatItRealtimeService = FireBeatItRealtimeService();
  TextEditingController bpmController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void _addToBeat(int input, int row, int beat) {
    soundEngine.addToBeat(input, row, beat);
  }

  void _removeFromBeat(int input, int row, int beat) {
    soundEngine.removeFromBeat(input, row, beat);
  }

  void _playSingleSound(String soundName) {
    soundEngine.playSingleSound(soundName);
  }

  void _play() {
    soundEngine.play();
  }

  void changeBPM(int bpm)
  {
    soundEngine.changeBPM(bpm);
  }

  @override
  Widget build(BuildContext context) {
    var dropdownValue;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 44, 41, 41),
        leading: Center(
          child: SvgPicture.asset(
            "assets/images/ZiiQue-Logo.svg",
            fit: BoxFit.scaleDown,
          ),
        ),
        leadingWidth: 120,
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
        beatBoardDesktop: BeatBoardDesktop(context),
        soundEngine: soundEngine,
        notifer: notifer,
      ),
      body: FirebaseAuth.instance.currentUser != null ? FutureBuilder(
          future: userquery,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              beatuser = snapshot.data;
              return Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        "../assets/images/Ziique_back_grey.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                /*
            BeatBoard settings starts here ---------------------------------------------------------------------------------------------------------------------
             */
                child: Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8, top: 100),
                        child: Container(
                          decoration: BoxDecoration(color: Colors.black),
                          child: Row(
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    _play();
                                  },
                                  child: const Text(
                                    'Play',
                                    style: TextStyle(fontSize: 8),
                                  )),
                              SizedBox(
                                  width: 100,
                                  child: TextFormField(
                                    controller: bpmController,
                                    style: TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                        hintText: 'BPM',
                                        hintStyle: TextStyle(
                                            color: Colors.white)),
                                  )),
                              ElevatedButton(
                                child: const Text("Save Beat"),
                                onPressed: (){
                                  showDialog(
                                    context: context, 
                                    builder: (context) => AlertDialog(
                                      title: const Text("Save Beat"),
                                        content: SizedBox(
                                          height: 150,
                                          width: 300,
                                          child: ListView(
                                            shrinkWrap: true,
                                            children: [
                                              TextFormField(
                                                controller: titleController,
                                                decoration: const InputDecoration(hintText: "Title"),
                                              ),
                                              const SizedBox(height: 20),
                                              TextFormField(
                                                controller: descriptionController,
                                                decoration: const InputDecoration(hintText: "Description"),
                                                maxLines: 3,
                                              ),
                                              ],
                                            ),
                                        ),
                                      actions: [
                                        TextButton(
                                          onPressed: (){
                                            Navigator.pop(context);
                                          }, 
                                          child: const Text("Cancel")),
                                        TextButton(
                                          onPressed: (){
                                            if (titleController.text.isNotEmpty && descriptionController.text.isNotEmpty){
                                              BeatService().saveBeat(FirebaseAuth.instance.currentUser,
                                              soundEngine.beatString,
                                              titleController.text,
                                              descriptionController.text
                                              );
                                              Navigator.pop(context);
                                            }
                                          }, 
                                          child: const Text("Save")),
                                          ],
                                        )
                                  );
                                }),
                              SizedBox(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width - 1100,
                              ),
                              GFDropdown(
                                  value: dropdownValue,
                                  items: [
                                    'Trap',
                                    'Hip-Hop',
                                    '3rd Wave Ska',
                                    'Dubstep'
                                  ]
                                      .map((value) =>
                                      DropdownMenuItem(
                                        value: value,
                                        child: Text(value),
                                      ))
                                      .toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      dropdownValue = newValue;
                                    });
                                  })
                            ],
                          ),
                        ),
                      ),
                    ),
                    FutureBuilder(
                      future: _calculation,
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        if (snapshot.hasData) {
                          return Expanded(
                            child: GridView.count(
                              padding:
                              const EdgeInsets.only(
                              left: 8, right: 8),
                              crossAxisCount: (numberOfBars * 4) + 1,
                              children: [
                                for (var i = 0;
                                i < ((numberOfBars * 4) + 1) * numberOfRows;
                                i++)
                                  Container(
                                    color: Colors.black,
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: StatefulBuilder(
                                        builder: (context, reload) {
                                          return ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: (alpha
                                                    .calcGreenBut(
                                                    i, numberOfBars) ==
                                                    0)
                                                    ? Colors.green
                                                    : BeatColor(
                                                    bar: numberOfBars)
                                                    .getColor(i)
                                                    ? (boolList[i] == true)
                                                    ? Colors.grey[900]
                                                    : Colors.grey
                                                    : (boolList[i] == true)
                                                    ? Colors.grey[900]
                                                    : Colors.blueGrey),
                                            onPressed: () {
                                              reload(() {
                                                alpha.greenBut == 0
                                                    ? _playSingleSound("A")
                                                    : _addToBeat(
                                                    i, numberOfRows,
                                                    numberOfBars);
                                                boolList[i] = !boolList[i];
                                                maxRange = (numberOfBars * 4);
                                                minRange = 1;
                                              });
                                            },
                                            child: Text(
                                              alpha.getAlphebat(
                                                  i, numberOfBars),
                                              style:
                                              const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          );
                                        },
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
      ) : Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("../assets/images/Ziique_back_grey.png"),
            fit: BoxFit.cover,
          ),
        ),
        /*
            BeatBoard settings starts here ---------------------------------------------------------------------------------------------------------------------
             */
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 100),
                child: Container(
                  decoration: BoxDecoration(color: Colors.black),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            _play();
                          },
                          child: const Text(
                            'Play',
                            style: TextStyle(fontSize: 8),
                          )),
                      SizedBox(
                        width: 30,
                      ),
                      SizedBox(
                          width: 100,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                        controller: bpmController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: 'BPM',
                            hintStyle: TextStyle(color: Colors.white)),
                            onChanged: (value) => changeBPM(int.parse(value)),
                      )),
                      SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width - 1100,
                      ),
                      GFDropdown(
                          value: dropdownValue,
                          items: [
                            'Trap',
                            'Hip-Hop',
                            '3rd Wave Ska',
                            'Dubstep'
                          ]
                              .map((value) =>
                              DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ))
                              .toList(),
                          onChanged: (newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          })
                    ],
                  ),
                ),
              ),
            ),
            FutureBuilder(
              future: _calculation,
              builder: (BuildContext context,
                  AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  return ValueListenableBuilder(
                    valueListenable: notifer.reload,
                    builder: (context, value, child) {
                      return Expanded(
                        child: GridView.count(
                          padding:
                          const EdgeInsets.only(
                              left: 8, right: 8),
                          crossAxisCount: (numberOfBars * 4) + 1,
                          children: [
                            for (var i = 0;
                            i < ((numberOfBars * 4) + 1) * numberOfRows;
                            i++)
                              Container(
                                color: Colors.black,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: StatefulBuilder(
                                    builder: (context, reload) {
                                      return ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: (alpha
                                                .calcGreenBut(
                                                i, numberOfBars) ==
                                                0)
                                                ? Colors.green
                                                : BeatColor(
                                                bar: numberOfBars)
                                                .getColor(i)
                                                ? (boolList[i] == true)
                                                ? Colors.grey[900]
                                                : Colors.grey
                                                : (boolList[i] == true)
                                                ? Colors.grey[900]
                                                : Colors.blueGrey),
                                        onPressed: () {
                                          boolList = LoadBeat().loadBeat(soundEngine, boolList);
                                          reload(() {
                                            alpha.greenBut == 0 ? _playSingleSound("A") : (boolList[i] ? _removeFromBeat(i, numberOfRows, numberOfBars) : _addToBeat(i, numberOfRows, numberOfBars));
                                            boolList[i] = !boolList[i];
                                            maxRange = (numberOfBars * 4);
                                            minRange = 1;
                                          });
                                        },
                                        child: Text(
                                          alpha.getAlphebat(
                                              i, numberOfBars),
                                          style:
                                          const TextStyle(
                                              color: Colors.white),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    }
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
  List<bool> loadBeat(SoundEngine soundEngine, List<bool> bools){
    print(bools);
    bools.every((element) => false);
    print(bools);
    nodes = soundEngine.nodeInt();
    print("Nodes : ${nodes}");
    for (var node in nodes){
      bools[node] = true;
    }
    return bools;
  }

}

class BeatColor {
  BeatColor({required this.bar});

  final int bar;

  bool getColor(int i) {
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
