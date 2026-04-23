// PLACEHOLDER — replace with real values by running `flutterfire configure`
// before the first real device run. This file lets `flutter build` succeed
// during Code Generation (PR A) without a Firebase project being configured
// yet; the Build and Test phase will regenerate it.
//
// The values below are non-functional. Production secrets are not required —
// Firebase config IDs are public by design (see firebase-setup.md).
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  const DefaultFirebaseOptions._();

  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.android:
        return android;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions is only wired for iOS + Android. '
          'Run `flutterfire configure` to regenerate for other platforms.',
        );
    }
  }

  // PLACEHOLDER — regenerate via `flutterfire configure` for a real project.
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'PLACEHOLDER_ANDROID_API_KEY',
    appId: '1:000000000000:android:0000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'overseas-safety-map',
    storageBucket: 'overseas-safety-map.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'PLACEHOLDER_IOS_API_KEY',
    appId: '1:000000000000:ios:0000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'overseas-safety-map',
    storageBucket: 'overseas-safety-map.appspot.com',
    iosBundleId: 'jp.go.mofa.overseas_safety_map',
  );
}
