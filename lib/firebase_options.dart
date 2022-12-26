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
    apiKey: 'AIzaSyAZ5fB0G0N5v1W5csf-2cID2qBurpjPtIc',
    appId: '1:1034780535242:web:2202e4be26aa1f26d9c733',
    messagingSenderId: '1034780535242',
    projectId: 'instagram-clone-course-naji',
    authDomain: 'instagram-clone-course-naji.firebaseapp.com',
    storageBucket: 'instagram-clone-course-naji.appspot.com',
    measurementId: 'G-S2EHFK4H0P',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCX74yDMPdNP6TG65POWePKveWgN6R2oSk',
    appId: '1:1034780535242:android:ecfc19a88a57a428d9c733',
    messagingSenderId: '1034780535242',
    projectId: 'instagram-clone-course-naji',
    storageBucket: 'instagram-clone-course-naji.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCXe46UOIMy-RumNPcI-MAsn7D0c14fgfM',
    appId: '1:1034780535242:ios:276f68b87defe418d9c733',
    messagingSenderId: '1034780535242',
    projectId: 'instagram-clone-course-naji',
    storageBucket: 'instagram-clone-course-naji.appspot.com',
    iosClientId: '1034780535242-d7uk0h48ko0vf8b51dafoi4u2hf2kfqf.apps.googleusercontent.com',
    iosBundleId: 'com.example.instagramCloneCourse',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCXe46UOIMy-RumNPcI-MAsn7D0c14fgfM',
    appId: '1:1034780535242:ios:276f68b87defe418d9c733',
    messagingSenderId: '1034780535242',
    projectId: 'instagram-clone-course-naji',
    storageBucket: 'instagram-clone-course-naji.appspot.com',
    iosClientId: '1034780535242-d7uk0h48ko0vf8b51dafoi4u2hf2kfqf.apps.googleusercontent.com',
    iosBundleId: 'com.example.instagramCloneCourse',
  );
}
