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
        return windows;
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
    apiKey: 'AIzaSyCNDxCQTh7vIL7nukVRgCD5NqQL9Oc_oqQ',
    appId: '1:282036476767:web:9c119edd8da276cc9a34ea',
    messagingSenderId: '282036476767',
    projectId: 'adast-425404',
    authDomain: 'adast-425404.firebaseapp.com',
    storageBucket: 'adast-425404.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBmbcfy-m0zedpbfYH2Do-Di-Nx8xl84JM',
    appId: '1:282036476767:android:cbd28a2fe0ba27519a34ea',
    messagingSenderId: '282036476767',
    projectId: 'adast-425404',
    storageBucket: 'adast-425404.appspot.com',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCNDxCQTh7vIL7nukVRgCD5NqQL9Oc_oqQ',
    appId: '1:282036476767:web:6032c2a187e1917f9a34ea',
    messagingSenderId: '282036476767',
    projectId: 'adast-425404',
    authDomain: 'adast-425404.firebaseapp.com',
    storageBucket: 'adast-425404.appspot.com',
  );
}