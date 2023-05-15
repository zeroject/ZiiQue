// ignore_for_file: library_prefixes, file_names, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart' as beatUser;
import '../models/fire_user.dart' as fireUser;

class CollectionNames{
  static const users = 'users';
}

class UserService{
  Future<beatUser.User> GetUser(fireUser.User fireUser) async {
    return (await FirebaseFirestore.instance
    .collection(CollectionNames.users)
    .doc(fireUser.uid).get()).data() as beatUser.User;
  }

  Future<void> CreateUser(fireUser.User? user, String firstName, String lastName) async {
    await FirebaseFirestore.instance
    .collection(CollectionNames.users)
    .doc(user!.uid)
    .set({
          beatUser.UserKeys.uid: user.uid,
          beatUser.UserKeys.firstname: firstName,
          beatUser.UserKeys.lastname: lastName,
          beatUser.UserKeys.friends: []
        });
  }

  Future<void> DeleteUser() async {
    await FirebaseFirestore.instance
    .collection(CollectionNames.users)
    .doc(FirebaseAuth.instance.currentUser?.uid)
    .delete();
  }
}