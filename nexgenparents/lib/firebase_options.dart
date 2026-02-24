import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyD_oOAdRhW-DIvtSyf5v3XWOrHi4Im7VpQ",
  authDomain: "nexgen-parents.firebaseapp.com",
  projectId: "nexgen-parents",
  storageBucket: "nexgen-parents.firebasestorage.app",
  messagingSenderId: "932380773717",
  appId: "1:932380773717:web:f74b8df601d471f473b3dc",
  measurementId: "G-WT5C0YV0SD"
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'TU_ANDROID_API_KEY',
    appId: 'TU_ANDROID_APP_ID',
    messagingSenderId: 'TU_SENDER_ID',
    projectId: 'TU_PROJECT_ID',
    storageBucket: 'TU_STORAGE_BUCKET',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'TU_IOS_API_KEY',
    appId: 'TU_IOS_APP_ID',
    messagingSenderId: 'TU_SENDER_ID',
    projectId: 'TU_PROJECT_ID',
    storageBucket: 'TU_STORAGE_BUCKET',
    iosBundleId: 'com.example.nexgenparents',
  );
}