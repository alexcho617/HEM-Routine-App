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
    apiKey: 'AIzaSyDENMWOD6788FUMTfm2w0J2kqs1iaIeyX4',
    appId: '1:438160748395:android:3dcd57a7b041fb32ffe62e',
    messagingSenderId: '438160748395',
    projectId: 'hem-routine-app-dev',
    storageBucket: 'hem-routine-app-dev.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCnOvTlNd0b-7KG_QQ6qVShH_5DKAfmrxM',
    appId: '1:438160748395:ios:93b59c6a2f0ab143ffe62e',
    messagingSenderId: '438160748395',
    projectId: 'hem-routine-app-dev',
    storageBucket: 'hem-routine-app-dev.appspot.com',
    androidClientId: '438160748395-43namt69s3t8gl4rm7iq030cf6ji8m77.apps.googleusercontent.com',
    iosClientId: '438160748395-2k0qk893o0olb6gsapsqgn7e6iugb18d.apps.googleusercontent.com',
    iosBundleId: 'com.swfact.hemRoutineApp',
  );
}
