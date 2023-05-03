

import 'package:cloud_firestore/cloud_firestore.dart';

class UserService{
  Future<void> GetUser(var userId) async {
    await FirebaseFirestore.instance
    .collection('users')
    .doc(userId)
    .get();
  }

  Future<void> CreateUser(var userId) async {
    await FirebaseFirestore.instance
    .collection('users')
    .add({
      
    })
  }
}