import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:ziique/CustomWidgets/custom_drawer.dart';
import 'package:ziique/CustomWidgets/custom_friend_listview.dart';
import 'package:ziique/FireService/fire_user_service.dart';
import 'package:ziique/login-create/create_widget.dart';
import 'package:ziique/login-create/login_widget.dart';
import 'package:ziique/sound_engine.dart';
import '../FireService/RealtimeData/fire_beatIt_realtime_service.dart';
import '../FireService/fire_beat_Service.dart';
import '../Settings/settings_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/Notifier.dart';
import '../models/user.dart' as beat_user;

int numberOfRows = 5;
int numberOfBars = 8;
int maxRange = (numberOfBars * 4);
int minRange = 1;
var dropdownValue = "Hip-Hop";

final snack = SnackBar(content: const Text("You have been invited to a session"), action: SnackBarAction(label: "accpet", onPressed: (){}));
SoundEngine soundEngine = SoundEngine();
Notifier notifer = Notifier();
LoadBeat _loadBeat = LoadBeat();
final Future<beat_user.User?> userquery =
    Future(() => UserService().getUser(FirebaseAuth.instance.currentUser!.uid));
beat_user.User? beatuser;

class BeatBoardDesktop extends StatefulWidget {
  const BeatBoardDesktop(BuildContext context, {super.key});

  @override
  State<BeatBoardDesktop> createState() => _BeatBoardDesktopState();
}

class _BeatBoardDesktopState extends State<BeatBoardDesktop> {
  late StateSetter internalSetter;
  late StateSetter startStopSession;
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
  FireBeatItRealtimeService fireBeatItRealtimeService =
      FireBeatItRealtimeService();
  TextEditingController bpmController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void loadBeat(String beatString){
    List<int> nodes = [];
    boolList = boolList.map<bool>((e) => false).toList();
    nodes = soundEngine.nodeInt(numberOfBars);
    for (var node in nodes) {
      boolList[node] = true;
    }
    soundEngine.beatString = beatString;
    internalSetter((){});
  }

  Future<void> _addToBeatLoggedin(int input, int row, int beat) async {
    soundEngine.addToBeat(input, row, beat);
    beat_user.User? user = await UserService().getUser(FirebaseAuth.instance.currentUser!.uid);
    if (user!.inSession){
      FireBeatItRealtimeService().setBeatString(user.sessionID, soundEngine.beatString);
      print(user.sessionID);
    }
  }

  Future<void> _removeFromBeatLoggedin(int input, int row, int beat) async {
    soundEngine.removeFromBeat(input, row, beat);
    beat_user.User? user = await UserService().getUser(FirebaseAuth.instance.currentUser!.uid);
    if (user!.inSession){
      FireBeatItRealtimeService().setBeatString(user.sessionID, soundEngine.beatString);
      print("Should update boarded");
    }
  }

  void _addToBeat(int input, int row, int beat) {
    soundEngine.addToBeat(input, row, beat);
  }

  void _removeFromBeat(int input, int row, int beat) {
    soundEngine.removeFromBeat(input, row, beat);
  }

  void _playSingleSound(int soundName) {
    soundEngine.playSingleSound(soundName);
  }

  void _play() {
    soundEngine.play();
  }

  void _changeTheme(String theme){
    soundEngine.changeTheme(theme);
  }

  void _clear()
  {
    soundEngine.beatString = "";
    //set all bools to false
    for (int i = 0; i < boolList.length; i++){
      boolList[i] = false;
      setState(() {
        boolList;
      });
    }
  }

  void changeBPM(int bpm) {
    soundEngine.changeBPM(bpm);
  }

  @override
  Widget build(BuildContext context) {
    const String start = "Start Session";
    const String stop = "Stop Session";
    bool cValue = false;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 44, 41, 41),
        leading: Center(
          child: Image.asset(
            "../assets/images/ZiiQue-Logo.png",
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
        settingsPageDesktop: SettingsPageMobile(context, initalScene: "Friends"),
        settingsPageMobile: SettingsPageMobile(context, initalScene: "Friends"),
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
        onLoadBeat: loadBeat,
      ),
      body: FirebaseAuth.instance.currentUser != null
          ? FutureBuilder(
              future: userquery,
              builder: (context, snapshot2) {
                if (!snapshot2.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  beatuser = snapshot2.data;
                  cValue = beatuser!.inSession;
                  return Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image:
                            AssetImage("../assets/images/Ziique_back_grey.png"),
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
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 100),
                            child: Container(
                              decoration: const BoxDecoration(color: Colors.black),
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
                                      ElevatedButton(
                                      onPressed: () {
                                        _clear();
                                      },
                                      child: const Text(
                                        'Clear',
                                        style: TextStyle(fontSize: 8),
                                         selectionColor: Color.fromARGB(255, 93, 43, 186),
                                      )),
                                  SizedBox(
                                      width: 100,
                                      child: TextFormField(
                                        controller: bpmController,
                                        style: const TextStyle(color: Colors.white),
                                        decoration: const InputDecoration(
                                            hintText: 'BPM',
                                            hintStyle:
                                                TextStyle(color: Colors.white)),
                                        onChanged: (value) =>
                                            changeBPM(int.parse(value)),
                                      )),
                                  ElevatedButton(
                                      child: const Text("Load From BeatCode"),
                                      onPressed: () {
                                        TextEditingController loadBeatController = TextEditingController();
                                        showDialog(
                                          context: context, 
                                          builder: (context) => AlertDialog(
                                            title: const Text("Load Beat From BeatCode"),
                                            content: TextFormField(
                                              controller: loadBeatController,
                                              decoration: const InputDecoration(hintText:"BeatCode"),
                                            ),
                                          actions: [
                                            TextButton(
                                              onPressed: (){
                                                Navigator.pop(context);
                                              }, 
                                              child: const Text("Cancel")),
                                            TextButton(
                                              onPressed: (){
                                                loadBeat(loadBeatController.text);
                                                Navigator.pop(context);
                                              }, 
                                              child: const Text("Ok")),
                                          ],
                                          ));
                                      }),
                                  ElevatedButton(
                                      child: const Text("Save Beat"),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title:
                                                      const Text("Save Beat"),
                                                  content: SizedBox(
                                                    height: 150,
                                                    width: 300,
                                                    child: ListView(
                                                      shrinkWrap: true,
                                                      children: [
                                                        TextFormField(
                                                          controller:
                                                              titleController,
                                                          decoration:
                                                              const InputDecoration(
                                                                  hintText:
                                                                      "Title"),
                                                        ),
                                                        const SizedBox(
                                                            height: 20),
                                                        TextFormField(
                                                          controller:
                                                              descriptionController,
                                                          decoration:
                                                              const InputDecoration(
                                                                  hintText:
                                                                      "Description"),
                                                          maxLines: 2,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                            "Cancel")),
                                                    TextButton(
                                                        onPressed: () {
                                                          if (titleController
                                                                  .text
                                                                  .isNotEmpty &&
                                                              descriptionController
                                                                  .text
                                                                  .isNotEmpty) {
                                                            BeatService().saveBeat(
                                                                FirebaseAuth
                                                                    .instance
                                                                    .currentUser,
                                                                soundEngine
                                                                    .beatString,
                                                                titleController
                                                                    .text,
                                                                descriptionController
                                                                    .text);
                                                            Navigator.pop(
                                                                context);
                                                          }
                                                        },
                                                        child:
                                                            const Text("Save")),
                                                  ],
                                                ));
                                      }),
                                  ElevatedButton(onPressed: () async {
                                    beat_user.User? user = await UserService().getUser(FirebaseAuth.instance.currentUser!.uid);
                                    if (user!.inSession == false){
                                      cValue = true;
                                      String id = await fireBeatItRealtimeService.createSession(soundEngine.beatString, FirebaseAuth.instance.currentUser!.uid);
                                      user!.sessionID = id;
                                      user.inSession = true;
                                      UserService().updateUser(user);
                                      fireBeatItRealtimeService.getBeatString(id, loadBeat);
                                      startStopSession(() {});
                                    } else {
                                      user.inSession = false;
                                      user.sessionID = "";
                                      UserService().updateUser(user);
                                      cValue = false;
                                    }
                                    }, child: StatefulBuilder(
                                      builder: (context, switchValue) {
                                        startStopSession = switchValue;
                                        return cValue ?  const Text("Quit session") : const Text(start);
                                      }
                                    )),
                                  ElevatedButton(onPressed: ()
                                  {
                                    showDialog(context: context, builder: (context) => AlertDialog(
                                      title: Text("Friends:"),
                                      content: SizedBox(
                                        height: 150,
                                        width: 300,
                                        child: Expanded(
                                          child: ListView(
                                            children: [
                                              CustomFriendListView(beatuser: beatuser),
                                            ],
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          }, 
                                          child: Text("Cancel")),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          }, 
                                          child: Text("Ok"))
                                      ],
                                    ));
                                  }, child: const Text("Add Friends")),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width -
                                        1100,
                                  ),
                                  DropdownButton<String>(
                                    value: dropdownValue,
                                    style: const TextStyle(color: Colors.deepPurple),
                                    onChanged: (value) {
                                      setState(() {
                                        _changeTheme(value.toString());
                                        dropdownValue = value!;
                                      });
                                    },
                                    items: <String>[
                                      'House',
                                      'Hip-Hop',
                                      'Acoustic',
                                      'Hardstyle',
                                    ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      },
                                    ).toList(),
                                  ),
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
                              return StatefulBuilder(
                                builder: (context, setter) {
                                  internalSetter = setter;
                                  return Expanded(
                                    child: GridView.count(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8),
                                      crossAxisCount: (numberOfBars * 4) + 1,
                                      children: [
                                        for (var i = 0;
                                            i <
                                                ((numberOfBars * 4) + 1) *
                                                    numberOfRows;
                                            i++)
                                          Container(
                                            color: Colors.black,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: StatefulBuilder(
                                                builder: (context, reload) {
                                                  return ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor: (alpha.calcGreenBut(i, numberOfBars) == 0) ? alpha.getColor(numberOfBars, i)
                                                                : BeatColor( bar: numberOfBars).getColor(i) ? (boolList[i] == true)
                                                                        ? Colors.grey[900] : Colors.grey
                                                                    : (boolList[i] == true) ? Colors.grey[900]
                                                                        : Colors.blueGrey),
                                                    onPressed: () {
                                                      reload(() {
                                                        alpha.greenBut == 0
                                                            ? _playSingleSound(
                                                                i)
                                                            :(boolList[i]
                                                            ? _removeFromBeatLoggedin(
                                                            i,
                                                            numberOfRows,
                                                            numberOfBars,)
                                                            : _addToBeatLoggedin(
                                                            i,
                                                            numberOfRows,
                                                            numberOfBars,));
                                                        boolList[i] =
                                                            !boolList[i];
                                                        maxRange =
                                                            (numberOfBars * 4);
                                                        minRange = 1;
                                                      });
                                                    },
                                                    child: const Text("",
                                                      style: TextStyle(
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
                                },
                              );
                            } else {
                              return const SizedBox(
                                height: 200,
                                child:
                                    Center(child: CircularProgressIndicator()),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  );
                }
              })
          : Container(
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
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, top: 100),
                      child: Container(
                        decoration: const BoxDecoration(color: Colors.black),
                        child: Row(
                          children: [
                            const SizedBox(
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
                                ElevatedButton(
                                      onPressed: () {
                                        _clear();
                                      },
                                      child: const Text(
                                        'Clear',
                                        style: TextStyle(fontSize: 8),
                                         selectionColor: Color.fromARGB(255, 93, 43, 186),
                                      )),
                            const SizedBox(
                              width: 30,
                            ),
                            SizedBox(
                                width: 100,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: bpmController,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                      hintText: 'BPM',
                                      hintStyle:
                                          TextStyle(color: Colors.white)),
                                  onChanged: (value) =>
                                      changeBPM(int.parse(value)),
                                )),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 1100,
                            ),
                        DropdownButton<String>(
                                    value: dropdownValue,
                                    style: const TextStyle(color: Colors.deepPurple),
                                    onChanged: (value) {
                                      setState(() {
                                        _changeTheme(value.toString());
                                        dropdownValue = value!;
                                      });
                                    },
                                    items: <String>[
                                      'House',
                                      'Hip-Hop',
                                      'Acoustic',
                                      'Hardstyle',
                                    ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      },
                                    ).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  FutureBuilder(
                    future: _calculation,
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasData) {
                              return Expanded(
                                child: GridView.count(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  crossAxisCount: (numberOfBars * 4) + 1,
                                  children: [
                                    for (var i = 0;
                                        i <
                                            ((numberOfBars * 4) + 1) *
                                                numberOfRows;
                                        i++)
                                      Container(
                                        color: Colors.black,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: StatefulBuilder(
                                            builder: (context, reload) {
                                              return ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: (alpha.calcGreenBut(i,numberOfBars) == 0) ? alpha.getColor(numberOfBars, i)
                                                        : BeatColor(bar : numberOfBars).getColor(i) ? (boolList[i] == true) ? Colors.grey[900]
                                                                : Colors.grey: (boolList[i] ==true) ? Colors.grey[900]
                                                                : Colors.blueGrey),
                                                onPressed: () {
                                                  reload(() {
                                                    alpha.greenBut == 0
                                                        ? _playSingleSound(i)
                                                        : (boolList[i]
                                                            ? _removeFromBeat(
                                                                i,
                                                                numberOfRows,
                                                                numberOfBars)
                                                            : _addToBeat(
                                                                i,
                                                                numberOfRows,
                                                                numberOfBars));
                                                    boolList[i] = !boolList[i];
                                                    maxRange =
                                                        (numberOfBars * 4);
                                                    minRange = 1;
                                                  });
                                                },
                                                child: const Text("",
                                                  style: TextStyle(
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
            ),
    );
  }
}

class Alpha {
  Map colors = {
    0: Colors.green,
    1: const Color.fromARGB(255, 2, 164, 245),
    2: const Color.fromARGB(255, 227, 11, 11),
    3: const Color.fromARGB(255, 202, 48, 195),
    4: const Color.fromARGB(255, 210, 194, 12),
  };

  Color getColor(int beat, int pos)
  {
    num baseVal = (numberOfBars * 4) + 1;
    num green = 0;
    for (num i = 0; i < numberOfRows; i++) {
      if (pos == (baseVal * i))
      {
      green = (baseVal * i);
      }
    }
          return colors[green / baseVal];
  }

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
