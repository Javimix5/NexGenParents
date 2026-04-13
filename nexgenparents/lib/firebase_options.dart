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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions only support web and android in this project.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD_oOAdRhW-DIvtSyf5v3XWOrHi4Im7VpQ',
    authDomain: 'nexgen-parents.firebaseapp.com',
    projectId: 'nexgen-parents',
    storageBucket: 'nexgen-parents.firebasestorage.app',
    messagingSenderId: '932380773717',
    appId: '1:932380773717:web:f74b8df601d471f473b3dc',
    measurementId: 'G-WT5C0YV0SD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAEYvrVyrj8JfvAepzXA2pO0LFOs2sbcCs',
    appId: '1:932380773717:android:a0799e82f016db5773b3dc',
    messagingSenderId: '932380773717',
    projectId: 'nexgen-parents',
    storageBucket: 'nexgen-parents.firebasestorage.app',
  );
}
