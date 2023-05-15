import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart' as beatUser;
import '../models/fire_user.dart' as fireUser;

class CollectionNames{
  static const users = 'users';
}

class UserService{
  Future<beatUser.User> getUser(fireUser.User fireUser) async {
    return (await FirebaseFirestore.instance
    .collection(CollectionNames.users)
    .doc(fireUser.uid).get()).data() as beatUser.User;
  }

  Future<void> createUser(fireUser.User? user, String firstName, String lastName) async {
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

  Future<void> deleteUser() async {
    await FirebaseFirestore.instance
    .collection(CollectionNames.users)
    .doc(FirebaseAuth.instance.currentUser?.uid)
    .delete();
  }
}