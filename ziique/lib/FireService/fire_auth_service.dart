import 'package:firebase_auth/firebase_auth.dart';

class SignInService{
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await FirebaseAuth.instance
    .signInWithEmailAndPassword(email: email, password: password);
  }
}

class SignUpService{
  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    await FirebaseAuth.instance
    .createUserWithEmailAndPassword(email: email, password: password);
  }
}

class SignOutService{
  Future<void> signOut() async {
    await FirebaseAuth.instance
    .signOut();
  }
}