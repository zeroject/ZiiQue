// ignore_for_file: non_constant_identifier_names, library_prefixes
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ziique/models/owner.dart';
import '../models/beat.dart';
import '../models/fire_user.dart' as fireUser;

class CollectionNames{
  static const beats = 'beats';
  static const users = 'users';
}

String generateId() {
  return Random().nextInt(2 ^ 53).toString();
}

class BeatService{
  Query<Beat> GetBeats(fireUser.User? user){
    return FirebaseFirestore.instance
    .collection(CollectionNames.users)
    .doc(user!.uid)
    .collection(CollectionNames.beats)
    .orderBy(BeatKeys.lastEdited)
    .withConverter(
      fromFirestore: (snapshot, options) => Beat.fromMap(snapshot.id, snapshot.data()!), 
      toFirestore: (value, options) => value.toMap(),
    );
  }

  Future<void> SaveBeat(fireUser.User? user, String beatstring) async {
    String id = generateId();
    final owner = Owner(
        uid: user!.uid,
        displayName: user.displayName ?? '',
        email: user.email ?? 'Unknown');
    await FirebaseFirestore.instance
        .collection(CollectionNames.users)
        .doc(user.uid)
        .collection(CollectionNames.beats)
        .doc(id)
        .set({
          BeatKeys.id: id,
          BeatKeys.lastEdited: FieldValue.serverTimestamp(),
          BeatKeys.by: owner.toMap(),
          BeatKeys.beatString: beatstring
        });
  }

  Future<void> UpdateBeat(fireUser.User user, var beatId, String beatstring) async{
    await FirebaseFirestore.instance
        .collection(CollectionNames.users)
        .doc(user.uid)
        .collection(CollectionNames.beats)
        .doc(beatId)
        .update({
          BeatKeys.lastEdited: FieldValue.serverTimestamp(),
          BeatKeys.beatString: beatstring
        });
  }

  Future<void> DeleteBeat(fireUser.User user, var beatId) async{
    await FirebaseFirestore.instance
        .collection(CollectionNames.users)
        .doc(user.uid)
        .collection(CollectionNames.beats)
        .doc(beatId)
        .delete();
  }
}