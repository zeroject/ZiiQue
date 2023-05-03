// ignore_for_file: non_constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ziique/models/owner.dart';
import '../models/beat.dart';
import '../models/user.dart';

class CollectionNames{
  static const beats = 'beats';
  static const users = 'users';
}

class BeatService{
  Stream<Iterable<Beat>> GetBeats(User user){
    return FirebaseFirestore.instance
    .collection(CollectionNames.beats)
    .where(OwnerKeys.uid, isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    .orderBy(BeatKeys.lastEdited)
    .withConverter(
      fromFirestore: (snapshot, options) => Beat.fromMap(snapshot.id, snapshot.data()!), 
      toFirestore: (value, options) => value.toMap(),
    )
    .snapshots()
    .map((querySnapshot) => querySnapshot.docs.map((e) => e.data()));
  }

  Future<void> SaveBeat(User user, String beatstring) async {
    final owner = Owner(
        uid: user.uid,
        displayName: user.displayName ?? '',
        email: user.email ?? 'Unknown');
    await FirebaseFirestore.instance
        .collection(CollectionNames.beats)
        .add({
      BeatKeys.lastEdited: FieldValue.serverTimestamp(),
      BeatKeys.from: owner.toMap(),
      BeatKeys.beatString: beatstring
    });
  }

  Future<void> UpdateBeat(User user, var beatId, String beatstring) async{
    final owner = Owner(
        uid: user.uid,
        displayName: user.displayName ?? '',
        email: user.email ?? 'Unknown');
    await FirebaseFirestore.instance
        .collection(CollectionNames.beats)
        .doc()
        .update()
  }

  void DeleteBeat(){

  }
}