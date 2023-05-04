import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';
import '../models/fire_user.dart' as fireUser;

class CollectionNames{
  static const users = 'users';
}

class UserService{
  Future<void> GetUser(var userId) async {
    await FirebaseFirestore.instance
    .collection(CollectionNames.users)
    .doc(userId)
    .get();
  }

  Future<void> CreateUser(fireUser.User user, String firstName, String lastName, DateTime birthday) async {
    await FirebaseFirestore.instance
    .collection(CollectionNames.users)
    .doc(user.uid)
    .set({
          UserKeys.uid: user.uid,
          UserKeys.firstname: firstName,
          UserKeys.lastname: lastName,
          UserKeys.birthday: birthday
        });
  }
}