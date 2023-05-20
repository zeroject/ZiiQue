import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:ziique/models/beatitsession.dart';

import '../../models/beat.dart';
import '../../models/user.dart';

class FireBeatItRealtimeService {
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  var uuid = const Uuid();
  Map<String ,String> users = {};
  int timeschanged = 0;
  int timesplayed = 0;
  int versionID = 1;

  Future<String> createSession(Beat beat, User host) async {
    try {
      String id = uuid.v4();
      BeatItSession beatItSession = BeatItSession(
          sessionid: id,
          usersadded: users,
          creationTime: DateTime.now().toString(),
          lastModified: DateTime.now().toString(),
          beatString: beat.beatString,
          timeschanged: timeschanged,
          timesplayed: timesplayed,
          hostID: host.uid,
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

  Future<void> addFriendToBeatItSession(String sessionID, User friend) async {
    try {
      final sessionRef = ref.child("beatItSessions").child(sessionID);
      DataSnapshot snapshot = await sessionRef.get();
      final dynamic sessionValue = snapshot.value;

      if (sessionValue != null && sessionValue is Map<String, dynamic>) {
        final useradded = sessionValue["usersadded"];
        final updateduserAdded = useradded != null ? Map.from(useradded) : {};
        updateduserAdded[friend.uid] = "PENDING";
        await sessionRef.child("usersadded").set(updateduserAdded);
      } else {
        throw Exception("Could not add friend to beat it together session");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> acceptInvToBeatItSession(String sessionID, User person) async {
    try {
      final sessionRef = ref.child("beatItSessions").child(sessionID);
      DataSnapshot snapshot = await sessionRef.get();
      final dynamic sessionValue = snapshot.value;

      if (sessionValue != null && sessionValue is Map<String, dynamic>) {
        final useradded = sessionValue["usersadded"];
        final updateduserAdded = useradded != null ? Map.from(useradded) : {};
        updateduserAdded[person.uid] = "ACCEPTED";
        await sessionRef.child("usersadded").set(updateduserAdded);
      } else {
        throw Exception("Could not accept inv to beat it together session");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> declineInvToBeatItSession(String sessionID, User person) async {
    try {
      final sessionRef = ref.child("beatItSessions").child(sessionID);
      DataSnapshot snapshot = await sessionRef.get();
      final dynamic sessionValue = snapshot.value;

      if (sessionValue != null && sessionValue is Map<String, dynamic>) {
        final useradded = sessionValue["usersadded"];
        final updateduserAdded = useradded != null ? Map.from(useradded) : {};
        updateduserAdded[person.uid] = "DECLINED";
        await sessionRef.child("usersadded").set(updateduserAdded);
      } else {
        throw Exception("Could not decline inv to beat it together session");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<String> listenToData(String sessionID) async{
    String beatString = "";
    final sessionRef = ref.child("beatItSessions").child(sessionID).child("beatString");
    sessionRef.onValue.listen((DatabaseEvent event){
      final data = event.snapshot.value;
      beatString = data.toString();
    });
    return beatString;
  }
}
