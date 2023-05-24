import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:ziique/models/owner.dart';
import '../models/beat.dart';
import '../models/fire_user.dart' as fire_user;

class CollectionNames{
  static const beats = 'beats';
  static const users = 'users';
}

String generateUid() {
  var uuid = const Uuid();
  return uuid.v4();
}

class BeatService{
  Query<Beat> getAllBeatsFromUser(String userUid){
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

  Query<Beat> getAllPublicBeatsFromUser(String userUid){
    return FirebaseFirestore.instance
    .collection(CollectionNames.users)
    .doc(userUid)
    .collection(CollectionNames.beats)
    .where('publicity', isEqualTo: 'Public')
    .orderBy(BeatKeys.lastEdited)
    .withConverter(
      fromFirestore: (snapshot, options) => Beat.fromMap(snapshot.id, snapshot.data()!), 
      toFirestore: (value, options) => value.toMap(),
    );
  }

  Future<void> saveBeat(fire_user.User? fireUser, String beatstring, String title, String description) async {
    String id = generateUid();
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
          BeatKeys.description: description,
          BeatKeys.publicity: "Private"
        });
  }

  Future<void> updateBeat(String userUid, Beat updatedBeat) async{
    await FirebaseFirestore.instance
        .collection(CollectionNames.users)
        .doc(userUid)
        .collection(CollectionNames.beats)
        .doc(updatedBeat.id)
        .update({
          BeatKeys.lastEdited: FieldValue.serverTimestamp(),
          BeatKeys.beatString: updatedBeat.beatString,
          BeatKeys.title: updatedBeat.title,
          BeatKeys.description: updatedBeat.description
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