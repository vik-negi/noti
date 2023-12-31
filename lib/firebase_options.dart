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
    apiKey: 'AIzaSyBSnktlewHsfxssOYKgfqech64VGWpm_6Y',
    appId: '1:1009812509944:android:6f7930f68d06046fdf570d',
    messagingSenderId: '1009812509944',
    projectId: 'videocall-d880d',
    storageBucket: 'videocall-d880d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDlNDZWLrAlxzgNngYipV5X1foc0Nsz9Wc',
    appId: '1:1009812509944:ios:5e0dba7b7f2d12b2df570d',
    messagingSenderId: '1009812509944',
    projectId: 'videocall-d880d',
    storageBucket: 'videocall-d880d.appspot.com',
    androidClientId: '1009812509944-rmqe167lmbeghgiu5fcl59ohs02omfp3.apps.googleusercontent.com',
    iosClientId: '1009812509944-o2m0jdjsn2ude65spao85p29a7tkfk81.apps.googleusercontent.com',
    iosBundleId: 'com.example.noti',
  );
}
