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
        return macos;
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
    apiKey: 'AIzaSyBMcirAo2PkglZdOYUaWgoBQHLgr2lCQnY',
    appId: '1:637166723446:web:c12b5ac27ad75b41f85a57',
    messagingSenderId: '637166723446',
    projectId: 'vending-machine-app-554dc',
    authDomain: 'vending-machine-app-554dc.firebaseapp.com',
    storageBucket: 'vending-machine-app-554dc.appspot.com',
    measurementId: 'G-DJXPZHY332',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDk-F7bpP-OG8sy0suIA-IjHVSPz7WEFrA',
    appId: '1:637166723446:android:64418041186d84c6f85a57',
    messagingSenderId: '637166723446',
    projectId: 'vending-machine-app-554dc',
    storageBucket: 'vending-machine-app-554dc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDojicqL3zLfJNK4kCVuig5Hs3g4m_2ppE',
    appId: '1:637166723446:ios:6bb84b5c4fb0f631f85a57',
    messagingSenderId: '637166723446',
    projectId: 'vending-machine-app-554dc',
    storageBucket: 'vending-machine-app-554dc.appspot.com',
    iosBundleId: 'com.example.vendingMachineTask',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDojicqL3zLfJNK4kCVuig5Hs3g4m_2ppE',
    appId: '1:637166723446:ios:7ed7535f911b80e2f85a57',
    messagingSenderId: '637166723446',
    projectId: 'vending-machine-app-554dc',
    storageBucket: 'vending-machine-app-554dc.appspot.com',
    iosBundleId: 'com.example.vendingMachineTask.RunnerTests',
  );
}
