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
    apiKey: 'AIzaSyDwoKOVWmPCBUiIF1K8Xz3I0pLsDSpbd0E',
    appId: '1:1036707976082:web:232e6604cfb948119c674b',
    messagingSenderId: '1036707976082',
    projectId: 'incitec-5ebe0',
    authDomain: 'incitec-5ebe0.firebaseapp.com',
    storageBucket: 'incitec-5ebe0.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAzguJ_ZP5wOP-pg74ijiMsb3yAp3MSFv0',
    appId: '1:1036707976082:android:dd87ad726236e1459c674b',
    messagingSenderId: '1036707976082',
    projectId: 'incitec-5ebe0',
    storageBucket: 'incitec-5ebe0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCLVQsSfeL18_mggCLPFdu7GtYSraI5KQU',
    appId: '1:1036707976082:ios:ad9694784fa062199c674b',
    messagingSenderId: '1036707976082',
    projectId: 'incitec-5ebe0',
    storageBucket: 'incitec-5ebe0.appspot.com',
    iosClientId: '1036707976082-6v3qkqdm1ep9drf7d9m2oe03ghdetveu.apps.googleusercontent.com',
    iosBundleId: 'com.example.incidenciasReportes',
  );
}
