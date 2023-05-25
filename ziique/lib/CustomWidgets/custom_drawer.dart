import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ziique/CustomWidgets/custom_friend_invlist.dart';
import 'package:ziique/FireService/RealtimeData/fire_beatIt_realtime_service.dart';
import '../models/user.dart' as our_user;
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:ziique/CustomWidgets/custom_expansion_tile.dart';
import 'package:ziique/FireService/fire_user_service.dart';
import 'package:ziique/sound_engine.dart';
import '../FireService/fire_beat_service.dart';
import '../models/beat.dart';
import '../FireService/fire_auth_service.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer(
      {super.key,
      @required required this.drawerWidth,
      required this.backgroundColor,
      required this.firebaseAuthUser,
      required this.drawerHeadHeight,
      required this.beatList,
      required this.settingsButHeight,
      required this.settingsButWidth,
      required this.settingsPageDesktop,
      required this.settingsPageMobile,
      required this.offsetHeight,
      required this.createAccButHeight,
      required this.createAccButWidth,
      required this.createButColor,
      required this.kIsWeb,
      required this.createPageDesktop,
      required this.createPageMobile,
      required this.loginButHeight,
      required this.loginButWidth,
      required this.loginPageDesktop,
      required this.loginPageMobile,
      required this.soundEngine,
      required this.beatBoardDesktop,
      required this.onLoadBeat,
      });

  final double drawerWidth;
  final Color backgroundColor;
  final bool firebaseAuthUser;
  final double drawerHeadHeight;
  final List beatList;
  final double settingsButHeight;
  final double settingsButWidth;
  final Widget settingsPageDesktop;
  final Widget settingsPageMobile;
  final Widget beatBoardDesktop;
  final SoundEngine soundEngine;
  final LoadBeatCallback onLoadBeat;

  //Not logged in
  final double offsetHeight;
  final double createAccButHeight;
  final double createAccButWidth;
  final Color createButColor;
  final bool kIsWeb;
  final Widget createPageDesktop;
  final Widget createPageMobile;
  final double loginButHeight;
  final double loginButWidth;
  final Widget loginPageDesktop;
  final Widget loginPageMobile;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  ListenData listenData = ListenData();
  late final Stream<QuerySnapshot> _userInvStream;
  final Future<our_user.User?> userquery = Future(
      () => UserService().getUser(FirebaseAuth.instance.currentUser!.uid));
  our_user.User? beatuser;

  @override
  Widget build(BuildContext context) {
    if(FirebaseAuth.instance.currentUser != null){
      _userInvStream = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("sessions").snapshots();
    }
    return SizedBox(
      width: widget.drawerWidth,
      child: Drawer(
        backgroundColor: widget.backgroundColor,
        child: FutureBuilder(
            future: userquery,
            builder: (context, snapshot) {
              return ListView(
                children: <Widget>[
                  if (widget.firebaseAuthUser) ...[
                    if (snapshot.hasData) ...[
                      if (snapshot.data!.inSession == true) ...[
                        CustomFriendInvListView(beatuser: snapshot.data, sessionID: snapshot.data!.sessionID),
                        OutlinedButton(
                          onPressed: () async {
                            our_user.User? user = await UserService().getUser(FirebaseAuth.instance.currentUser!.uid);
                            //FireBeatItRealtimeService().deleteSession(user!.sessionID, snapshot.data!.uid); // TODO Change Function
                            user!.inSession = false;
                            user.sessionID = "";
                            UserService().updateUser(user);
                            listenData.stopListeningToChanges();
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Stop Session",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ] else ...[
                        SizedBox(
                          height: widget.drawerHeadHeight,
                          child: DrawerHeader(
                            decoration: BoxDecoration(
                              color: widget.backgroundColor,
                            ),
                            child: Stack(
                              children: const [
                                Positioned(
                                  bottom: 8.0,
                                  left: 4.0,
                                  child: Text(
                                    "YOUR BEATS",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        FirestoreListView<Beat>(
                          shrinkWrap: true,
                          query: BeatService()
                              .getAllBeatsFromUser(FirebaseAuth.instance.currentUser!.uid),
                          itemBuilder: (BuildContext context, snapshot) {
                            Beat beatTOget = snapshot.data();
                                  return CustomExpansionTile(
                                      isFriendBeat: false,
                                      beat: beatTOget,
                                      fontSize: 20,
                                      tileColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                      tileRadius: 10,
                                      soundEngine: widget.soundEngine,
                                    onLoadBeat: widget.onLoadBeat,
                                    listenData: listenData,
                                  );
                          },
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: SizedBox(
                                  width: widget.settingsButWidth,
                                  height: widget.settingsButHeight,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  widget.settingsPageDesktop));
                                    },
                                    child: const Text("Account Settings",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: SizedBox(
                                  width: widget.settingsButWidth,
                                  height: widget.settingsButHeight,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      AuthService().signOut();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  widget.beatBoardDesktop));
                                    },
                                    child: const Text(
                                      "Log Out",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 100,
                          child: StreamBuilder<QuerySnapshot>(
                              stream: _userInvStream,
                              builder: (context, doc){
                                if (doc.hasError){}

                                if (doc.connectionState == ConnectionState.waiting){

                                }
                                return ListView(
                                  shrinkWrap: true,
                                  children: doc.data!.docs.map((DocumentSnapshot document) {
                                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                    return ListTile(
                                      title: const Text("Session INV"),
                                      subtitle: const Text("From User TODO ADD USER NAME HERE"),
                                      onTap: () async {
                                        FireBeatItRealtimeService().respondInvToBeatItSession(document.id, snapshot.data!.uid, true);
                                        our_user.User? user = await UserService().getUser(FirebaseAuth.instance.currentUser!.uid);
                                        user!.sessionID = document.id;
                                        user.inSession = true;
                                        UserService().updateUser(user);
                                        listenData.Listen(document.id, widget.soundEngine, widget.onLoadBeat);
                                        Navigator.pop;
                                      },
                                    );
                                  }).toList(),
                                );
                              }
                          ),
                        )
                      ],
                    ] else ...[
                      const CircularProgressIndicator(),
                      const CircularProgressIndicator(),
                      const CircularProgressIndicator(),
                      const CircularProgressIndicator(),
                      const CircularProgressIndicator(),
                    ]
                  ] else ...[
                    Column(
                      children: [
                        SizedBox(
                          height: widget.offsetHeight,
                        ),
                        const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "It seems you are not logged in",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          child: SizedBox(
                            height: widget.createAccButHeight,
                            width: widget.createAccButWidth,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: widget.createButColor),
                              onPressed: () {
                                if (widget.kIsWeb) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              widget.createPageDesktop));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              widget.createPageMobile));
                                }
                              },
                              child: const Text(
                                "Create Account",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Already have an account?",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                        Align(
                          child: SizedBox(
                            height: widget.loginButHeight,
                            width: widget.loginButWidth,
                            child: TextButton(
                              onPressed: () {
                                if (widget.kIsWeb) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              widget.loginPageDesktop));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              widget.loginPageMobile));
                                }
                              },
                              child: const Text(
                                "Log in",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 25),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        widget.settingsPageMobile));
                          },
                          child: const Text("Account Settings",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ],
                ],
              );
            }),
      ),
    );
  }
}

typedef LoadBeatCallback = void Function(String beatString);