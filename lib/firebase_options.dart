// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return ios;
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
    apiKey: 'AIzaSyCuyMStq83L2F-5rswtYLWzijyI24z1V0Q',
    appId: '1:1064432089588:web:dae173e6947bf70b3d21a1',
    messagingSenderId: '1064432089588',
    projectId: 'notbox-4df33',
    authDomain: 'notbox-4df33.firebaseapp.com',
    storageBucket: 'notbox-4df33.appspot.com',
    measurementId: 'G-GSRSMXK0EZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA0Ekv7-Bnxwogyn2lJ8ckG0lxmXpxsKkc',
    appId: '1:1064432089588:android:32f2b7aa8f938a283d21a1',
    messagingSenderId: '1064432089588',
    projectId: 'notbox-4df33',
    storageBucket: 'notbox-4df33.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBlnM48Mi81E-QZJywuPLVFX-_QW-yiB6c',
    appId: '1:1064432089588:ios:b4b2de1429f1aa223d21a1',
    messagingSenderId: '1064432089588',
    projectId: 'notbox-4df33',
    storageBucket: 'notbox-4df33.appspot.com',
    iosBundleId: 'com.example.notebox',
  );
}
