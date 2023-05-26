// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
      apiKey: "AIzaSyCVklS2SI8pUdP96DBiUsA2iyoYqub2MTI",
      authDomain: "ziique-e74ad.firebaseapp.com",
      databaseURL: "https://ziique-e74ad-default-rtdb.europe-west1.firebasedatabase.app",
      projectId: "ziique-e74ad",
      storageBucket: "ziique-e74ad.appspot.com",
      messagingSenderId: "620903528169",
      appId: "1:620903528169:web:2a5d008559bb135cc46278"
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBPH9nc7rJYVMjgUar09MVkKjnxDRny12w',
    appId: '1:781887836387:android:e6a96438252d7725b1b5d6',
    messagingSenderId: '781887836387',
    projectId: 'ziique-7aa1b',
    databaseURL: 'https://ziique-7aa1b-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'ziique-7aa1b.appspot.com',
  );
}
