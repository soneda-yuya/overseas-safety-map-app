// PLACEHOLDER — replace with real values by running `flutterfire configure`
// before the first real device run. This file lets `flutter build` succeed
// during Code Generation (PR A) without a Firebase project being configured
// yet; the Build and Test phase will regenerate it.
//
// The values below are non-functional. Production secrets are not required —
// Firebase config IDs are public by design (see
// aidlc-docs/construction/U-APP/infrastructure-design/firebase-setup.md).
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  const DefaultFirebaseOptions._();

  static FirebaseOptions get currentPlatform {
    // `defaultTargetPlatform` on web reports iOS / Android depending on the
    // UA, which would silently hand back mobile config. Gate web first so
    // the error surfaces instead of an implicit wrong platform.
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions is not wired for web in MVP. '
        'Run `flutterfire configure --platforms=web` to regenerate.',
      );
    }
    final options = switch (defaultTargetPlatform) {
      TargetPlatform.iOS => ios,
      TargetPlatform.android => android,
      _ => throw UnsupportedError(
          'DefaultFirebaseOptions is only wired for iOS + Android. '
          'Run `flutterfire configure` to regenerate for other platforms.',
        ),
    };
    // Fail fast on the scaffold values shipped in PR A. Without this guard
    // Firebase.initializeApp succeeds and the first real API call fails far
    // from the root cause.
    if (options.apiKey.startsWith('PLACEHOLDER_')) {
      throw UnsupportedError(
        'firebase_options.dart still contains PR A placeholder values. '
        'Run `flutterfire configure` to generate real config before running '
        'on a device.',
      );
    }
    return options;
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
