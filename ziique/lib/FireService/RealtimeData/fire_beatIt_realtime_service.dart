import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:ziique/models/beatitsession.dart';

import '../../models/beat.dart';
import '../../models/user.dart';

class Fire_BeatIt_Realtime_Service {
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
    } catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
  }
}