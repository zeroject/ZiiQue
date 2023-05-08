// ignore_for_file: library_prefixes, file_names, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart';
import '../models/fire_user.dart' as fireUser;

class CollectionNames{
  static const users = 'users';
}

class UserService{
  Future<void> GetUser(fireUser.User fireUser) async {
    await FirebaseFirestore.instance
    .collection(CollectionNames.users)
    .doc(fireUser.uid)
    .get();
  }

  Future<void> CreateUser(fireUser.User? user, String firstName, String lastName) async {
    await FirebaseFirestore.instance
    .collection(CollectionNames.users)
    .doc(user!.uid)
    .set({
          UserKeys.uid: user.uid,
          UserKeys.firstname: firstName,
          UserKeys.lastname: lastName
        });
  }

  Future<void> DeleteUser() async {
    await FirebaseFirestore.instance
    .collection(CollectionNames.users)
    .doc(FirebaseAuth.instance.currentUser?.uid)
    .delete();
  }
}