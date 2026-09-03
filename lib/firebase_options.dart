// File generated for FlutterFire configuration.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
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
    apiKey: 'AIzaSyAfZ1ltb_UtjizZJsRCVeXNbo8q8KIBU_I',
    appId: '1:953324306666:web:4b47516776a52ecf5b9793',
    messagingSenderId: '953324306666',
    projectId: 'my-quran-app-e56f2',
    authDomain: 'my-quran-app-e56f2.firebaseapp.com',
    storageBucket: 'my-quran-app-e56f2.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAfZ1ltb_UtjizZJsRCVeXNbo8q8KIBU_I',
    appId: '1:953324306666:android:4b47516776a52ecf5b9793',
    messagingSenderId: '953324306666',
    projectId: 'my-quran-app-e56f2',
    storageBucket: 'my-quran-app-e56f2.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAfZ1ltb_UtjizZJsRCVeXNbo8q8KIBU_I',
    appId: '1:953324306666:ios:4b47516776a52ecf5b9793',
    messagingSenderId: '953324306666',
    projectId: 'my-quran-app-e56f2',
    storageBucket: 'my-quran-app-e56f2.firebasestorage.app',
  );
}
