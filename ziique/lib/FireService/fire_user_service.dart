import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart' as beat_user;
import '../models/fire_user.dart' as fire_user;

class CollectionNames{
  static const users = 'users';
}

class UserService{
  Future<beat_user.User> getUser(fire_user.User fireUser) async {
    return (await FirebaseFirestore.instance
    .collection(CollectionNames.users)
    .doc(fireUser.uid).get()).data() as beat_user.User;
  }

  Future<void> createUser(fire_user.User? user, String firstName, String lastName) async {
    await FirebaseFirestore.instance
    .collection(CollectionNames.users)
    .doc(user!.uid)
    .set({
          beat_user.UserKeys.uid: user.uid,
          beat_user.UserKeys.firstname: firstName,
          beat_user.UserKeys.lastname: lastName,
          beat_user.UserKeys.friends: []
        });
  }

  Future<void> deleteUser() async {
    await FirebaseFirestore.instance
    .collection(CollectionNames.users)
    .doc(FirebaseAuth.instance.currentUser?.uid)
    .delete();
  }
}