import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:ziique/BeatBoard/beat_board_widget.dart';
import 'package:ziique/CustomWidgets/custom_expansion_tile.dart';
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
  var uuid = const Uuid();
  Map<String, String> users = {};
  int timeschanged = 0;
  int timesplayed = 0;
  int versionID = 1;

  Future<String> createSession(Beat? beat, String hostUID) async{
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
    DocumentReference sessionRef = FirebaseFirestore.instance.collection("Sessions").doc(beatItSession.sessionid);
    await sessionRef.set(beatItSession.toMap());
    return id;
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
    Map<String, dynamic> ref = (await FirebaseFirestore.instance.collection("Sessions").doc(sessionID).get().then((DocumentSnapshot doc){
      final data = doc.data() as Map<String, dynamic>;
      return data;
    }));
    ref["usersadded"] = "${ref["usersadded"]}, $person";
    await FirebaseFirestore.instance.collection("Sessions").doc(sessionID).update(ref);
    return respond;
  }
}

class ListenData{
  ListenData();

  final DatabaseReference reference = FirebaseDatabase.instance.ref();

  Listen(String sessionID, SoundEngine? soundEngine, LoadBeatCallback? onLoadBeat){
    final sessionRef = reference.child("beatItSessions").child(sessionID).child("beatString");
    sessionRef.onValue.listen((DatabaseEvent event) async {
      print("we inside the music");
      print(event.snapshot.value.toString());
      soundEngine!.beatString = event.snapshot.value.toString();
      onLoadBeat!(event.snapshot.value.toString());
    });
  }
  void stopListeningToChanges() {
    reference.onValue.drain();
  }
}
