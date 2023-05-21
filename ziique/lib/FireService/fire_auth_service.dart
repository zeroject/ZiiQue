import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await FirebaseAuth.instance
    .signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    await FirebaseAuth.instance
    .createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance
    .signOut();
  }

  Future<void> reauthenticate(AuthCredential credential) async {
    await FirebaseAuth.instance.currentUser!
    .reauthenticateWithCredential(credential);
  }
}

class ChangeCredentialsService{
  Future<void> changeDisplayName(String newDisplayName) async{
    await FirebaseAuth.instance.currentUser!.updateDisplayName(newDisplayName);
  }

  Future<void> changeEmail(String newEmail) async{
    await FirebaseAuth.instance.currentUser!.updateEmail(newEmail);
  }

  Future<void> changePassword(String newPassword) async{
    await FirebaseAuth.instance.currentUser!.updatePassword(newPassword);
  }
}