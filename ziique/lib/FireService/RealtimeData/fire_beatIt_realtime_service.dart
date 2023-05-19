import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:ziique/models/beatitsession.dart';

import '../../models/beat.dart';
import '../../models/user.dart';

class FireBeatItRealtimeService {
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  var uuid = const Uuid();
  List<User> users = [];
  int timeschanged = 0;
  int timesplayed = 0;
  int versionID = 1;
  Future<void> createSession(Beat beat, User host) async{
    String id = uuid.v4();
    try{
      BeatItSession beatItSession = BeatItSession(
          id,
          users,
          DateTime.now(),
          DateTime.now(),
          beat,
          timeschanged,
          timesplayed,
          host,
          versionID);
      final sessionRef = ref.child("beatItSessions").child(id);
      await sessionRef.set(beatItSession.toMap());
    } catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
  }
  Future<void> addFriendToBeatItSession(String sessionID, User friend) async{
    try{
      final sessionRef = ref.child("beatItSessions").child(sessionID);
      DataSnapshot snapshot = await sessionRef.get();
      final dynamic sessionValue = snapshot.value;

      if (sessionValue != null && sessionValue is Map<dynamic, dynamic>){
        final useradded = sessionValue["usersadded"];
        final updateduserAdded = useradded != null ? Map.from(useradded) : {};
        updateduserAdded[friend.uid] = 0;
        await sessionRef.child("usersadded").set(updateduserAdded);
      } else {
        print("ooh fuck we fucked big time shitting my pabts");
      }
    } catch (e){
      if (kDebugMode) {
        print(e);
      }
    }
  }
}