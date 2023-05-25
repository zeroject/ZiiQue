import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:ziique/FireService/fire_beat_Service.dart';
import 'package:ziique/models/beatitsession.dart';
import 'package:cloud_functions/cloud_functions.dart';

import '../../models/beat.dart';
import '../../models/user.dart' as beat_user;

/*
  Mangler at fåret lavet et ping system så den anden ved hvornår han er blevet inviteret så personen kan svare og join sessionen med litenOnData.
  men har ingen ideer lige nu how eller hvordan. Måske cloud functions.
 */

class FireBeatItRealtimeService {
  CollectionReference sessionRef = FirebaseFirestore.instance.collection("Sessions");
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
    DocumentReference docRef = sessionRef.doc(beatItSession.sessionid);
    await docRef.set(beatItSession.toMap());
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
    Map<String, dynamic> ref = (await sessionRef.doc(sessionID).get().then((DocumentSnapshot doc){
      final data = doc.data() as Map<String, dynamic>;
      return data;
    }));
    ref["usersadded"] = {person : respond};
    await FirebaseFirestore.instance.collection("Sessions").doc(sessionID).update(ref);
    return respond;
  }


  Stream<String> getBeatString(String sessionID){
    return sessionRef.doc(sessionID).snapshots().asyncMap((snapshot){
      if (snapshot.exists){
        final data = snapshot.data() as Map<String, dynamic>;
        final String beatString = data["beatString"];

        if (beatString != ""){
          return beatString.toString();
        }
      }
      return "ERROR";
    });
  }

  stopStreams(String sessionID){
    sessionRef.doc(sessionID).snapshots().drain();
  }

  Future<void> setBeatString(String sessionID, String beatString) async {
    try{
      final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable("setBeatString");

      final result = await callable.call({
        'sessionID' : sessionID,
        'beatString' : beatString,
      });
      final data = result.data as Map<String, dynamic>;
      final succes = data['success'] as bool;
      if (succes){
        print("Succes this client got the beat string");
      } else{
        print("Error this client did not get ");
      }
    } catch (error){
      print("whoops, could not call setBeatString statement");
    }
  }

}
