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
///  );
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
    apiKey: 'AIzaSyAiEo8Ae13H5t57hOnhvQ5jWaT_1-tP5sE',
    appId: '1:521345784333:web:24f23fd77b53515e925344',
    messagingSenderId: '521345784333',
    projectId: 'havierdevelopment',
    authDomain: 'havierdevelopment.firebaseapp.com',
    storageBucket: 'havierdevelopment.appspot.com',
    measurementId: 'G-BH7845BCNS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD3CtwBRjQS6ux_yg0q_kT-T_DoUmnKlJA',
    appId: '1:521345784333:android:4fa196c6f6a74499925344',
    messagingSenderId: '521345784333',
    projectId: 'havierdevelopment',
    storageBucket: 'havierdevelopment.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCzq9CcTrxsSWL-33fj1DxxEps1oCn36lA',
    appId: '1:521345784333:ios:1e0acde277f81ed0925344',
    messagingSenderId: '521345784333',
    projectId: 'havierdevelopment',
    storageBucket: 'havierdevelopment.appspot.com',
    iosClientId: '521345784333-alsfceh18lcd3kdf0d5vsss0mbgjl7dq.apps.googleusercontent.com',
    iosBundleId: 'dev.havier.havierCluedoTool',
  );
}
