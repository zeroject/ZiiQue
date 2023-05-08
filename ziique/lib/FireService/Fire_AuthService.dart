// ignore_for_file: non_constant_identifier_names, file_names
import 'package:firebase_auth/firebase_auth.dart';

class SignInService{
  Future<void> SignInWithEmailAndPassword(String email, String password) async {
    await FirebaseAuth.instance
    .signInWithEmailAndPassword(email: email, password: password);
  }
}

class SignUpService{
  Future<void> SignUpWithEmailAndPassword(String email, String password) async {
    await FirebaseAuth.instance
    .createUserWithEmailAndPassword(email: email, password: password);
  }
}

class SignOutService{
  Future<void> SignOut() async {
    await FirebaseAuth.instance
    .signOut();
  }
}