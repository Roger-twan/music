import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for android - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAbEoH_Njt1JYJ9HI95zRRiluZzxlyCHXk',
    appId: '1:790432947868:ios:8df574d9653707eafed759',
    messagingSenderId: '790432947868',
    projectId: 'music-7acb9',
    storageBucket: 'music-7acb9.appspot.com',
    iosClientId:
        '790432947868-5u5svat5ja06kpm1f6753div5l6to2sl.apps.googleusercontent.com',
    iosBundleId: 'com.example.roger-music',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAbEoH_Njt1JYJ9HI95zRRiluZzxlyCHXk',
    appId: '1:790432947868:ios:16890656172e2109fed759',
    messagingSenderId: '790432947868',
    projectId: 'music-7acb9',
    storageBucket: 'music-7acb9.appspot.com',
    iosClientId:
        '790432947868-pilrq6kv7qdm7v3bki4s0k21ah2dj073.apps.googleusercontent.com',
    iosBundleId: 'com.example.music',
  );
}
