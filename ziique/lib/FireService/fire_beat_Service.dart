import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ziique/models/owner.dart';
import '../models/beat.dart';
import '../models/fire_user.dart' as fire_user;

class CollectionNames{
  static const beats = 'beats';
  static const users = 'users';
}

String generateId() {
  return Random().nextInt(2 ^ 53).toString();
}

class BeatService{
  Query<Beat> getBeats(String userUid){
    return FirebaseFirestore.instance
    .collection(CollectionNames.users)
    .doc(userUid)
    .collection(CollectionNames.beats)
    .orderBy(BeatKeys.lastEdited)
    .withConverter(
      fromFirestore: (snapshot, options) => Beat.fromMap(snapshot.id, snapshot.data()!), 
      toFirestore: (value, options) => value.toMap(),
    );
  }

  Future<void> saveBeat(fire_user.User? fireUser, String beatstring, String title, String description) async {
    String id = generateId();
    final owner = Owner(
        uid: fireUser!.uid,
        displayName: fireUser.displayName ?? '',
        email: fireUser.email ?? 'Unknown');
    await FirebaseFirestore.instance
        .collection(CollectionNames.users)
        .doc(fireUser.uid)
        .collection(CollectionNames.beats)
        .doc(id)
        .set({
          BeatKeys.id: id,
          BeatKeys.title: title,
          BeatKeys.lastEdited: FieldValue.serverTimestamp(),
          BeatKeys.by: owner.toMap(),
          BeatKeys.beatString: beatstring,
          BeatKeys.description: description
        });
  }

  Future<void> updateBeat(String userUid, String beatId, String beatstring) async{
    await FirebaseFirestore.instance
        .collection(CollectionNames.users)
        .doc(userUid)
        .collection(CollectionNames.beats)
        .doc(beatId)
        .update({
          BeatKeys.lastEdited: FieldValue.serverTimestamp(),
          BeatKeys.beatString: beatstring
        });
  }

  Future<void> deleteBeat(String userUid, String beatId) async{
    await FirebaseFirestore.instance
        .collection(CollectionNames.users)
        .doc(userUid)
        .collection(CollectionNames.beats)
        .doc(beatId)
        .delete();
  }
}