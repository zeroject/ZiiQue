import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:ziique/BeatBoard/beat_board_widget.dart';
import 'package:ziique/FireService/fire_beat_Service.dart';
import 'package:ziique/models/beatitsession.dart';
import 'package:ziique/sound_engine.dart';

import '../../models/beat.dart';
import '../../models/user.dart' as beat_user;

/*
  Mangler at fåret lavet et ping system så den anden ved hvornår han er blevet inviteret så personen kan svare og join sessionen med litenOnData.
  men har ingen ideer lige nu how eller hvordan. Måske cloud functions.
 */

class FireBeatItRealtimeService {
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  var uuid = const Uuid();
  Map<String, String> users = {};
  int timeschanged = 0;
  int timesplayed = 0;
  int versionID = 1;

  Future<String> createSession(Beat? beat, String hostUID) async {
    try {
      String id = uuid.v4();
      BeatItSession beatItSession = BeatItSession(
          sessionid: id,
          usersadded: users,
          creationTime: DateTime.now().toString(),
          lastModified: DateTime.now().toString(),
          beatString: beat!.beatString,
          timeschanged: timeschanged,
          timesplayed: timesplayed,
          hostID: hostUID,
          versionid: versionID);
      final sessionRef = ref.child("beatItSessions").child(id);
      await sessionRef.set(beatItSession.toMap());
      return id;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw Exception("Could not create Beat It Together session");
    }
  }

  deleteSession(String sessionID, String userID) async {
    final sessionRef = ref.child("beatItSessions").child(sessionID);
    final snapshot = await sessionRef.child("hostID").get();
    if (userID == snapshot.value) {
      print("should delete the current session");
      sessionRef.remove();
    }
  }

  Future<void> addFriendToBeatItSession(
      String sessionID, beat_user.User friend) async {
    await FirebaseFirestore.instance
        .collection(CollectionNames.users)
        .doc(friend.uid)
        .collection("sessions")
        .doc(sessionID)
        .set({"hostID": FirebaseAuth.instance.currentUser!.uid});
  }

  Future<bool> respondInvToBeatItSession(
      String sessionID, String person, bool respond) async {
    await FirebaseFirestore.instance
        .collection(CollectionNames.users)
        .doc(person)
        .collection("sessions")
        .doc(sessionID)
        .delete();
    return respond;
  }

  Future<void> listenToData(String sessionID, SoundEngine? soundEngine) async {
    print(sessionID);
    final sessionRef = ref.child("beatItSessions").child(sessionID);
    sessionRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.children;
      data.map((DataSnapshot dataSnapshot) {
        Map<String, dynamic> data =
            dataSnapshot.children as Map<String, dynamic>;
        soundEngine!.beatString = data['beatString'];
      });
    });
  }

  Future<void> updateData(String sessionID, String beatString) async {
    final sessionRef = ref.child("beatItSessions").child(sessionID);
    sessionRef.update({"beatString": beatString});
  }
}
