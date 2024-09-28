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
        return macos;
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
    apiKey: 'AIzaSyBU0MdgiP2P5YNopUAUeGky93EWxOyVQ9U',
    appId: '1:697435246721:web:2ab4ea135279ffc8c6fd80',
    messagingSenderId: '697435246721',
    projectId: 'archa-65f12',
    authDomain: 'archa-65f12.firebaseapp.com',
    storageBucket: 'archa-65f12.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBF_hkDR0CTvQ-HgsM9DJl39LKO5B-FgL0',
    appId: '1:697435246721:android:1b3cfd8ede0ffd9ec6fd80',
    messagingSenderId: '697435246721',
    projectId: 'archa-65f12',
    storageBucket: 'archa-65f12.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDJGjzl-P7IY2xGPuOVuoF46vmU0PIkuTc',
    appId: '1:697435246721:ios:2953c7e10d50de04c6fd80',
    messagingSenderId: '697435246721',
    projectId: 'archa-65f12',
    storageBucket: 'archa-65f12.appspot.com',
    iosBundleId: 'com.example.archa',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDJGjzl-P7IY2xGPuOVuoF46vmU0PIkuTc',
    appId: '1:697435246721:ios:2953c7e10d50de04c6fd80',
    messagingSenderId: '697435246721',
    projectId: 'archa-65f12',
    storageBucket: 'archa-65f12.appspot.com',
    iosBundleId: 'com.example.archa',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBU0MdgiP2P5YNopUAUeGky93EWxOyVQ9U',
    appId: '1:697435246721:web:e3d0bf935cac44d5c6fd80',
    messagingSenderId: '697435246721',
    projectId: 'archa-65f12',
    authDomain: 'archa-65f12.firebaseapp.com',
    storageBucket: 'archa-65f12.appspot.com',
  );
}
