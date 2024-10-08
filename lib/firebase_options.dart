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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDR4IuWpmcLDLqBKKp37vRqukBXlPm1O4c',
    appId: '1:172407271569:android:0978ff29ce8b7e5ed50f30',
    messagingSenderId: '172407271569',
    projectId: 'groceries-app-b740c',
    databaseURL: 'https://groceries-app-b740c-default-rtdb.firebaseio.com',
    storageBucket: 'groceries-app-b740c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD4K0VUEzRCle0ghIPDJ9EOsTWUmRgEiLM',
    appId: '1:172407271569:ios:bc5324272497eae1d50f30',
    messagingSenderId: '172407271569',
    projectId: 'groceries-app-b740c',
    databaseURL: 'https://groceries-app-b740c-default-rtdb.firebaseio.com',
    storageBucket: 'groceries-app-b740c.appspot.com',
    iosBundleId: 'com.example.fusionEaseApp',
  );
}
