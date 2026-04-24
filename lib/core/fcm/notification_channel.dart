import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

/// Configures FCM presentation so incoming notifications behave correctly on
/// each platform. Invoked from `main.dart` before `runApp`.
///
/// iOS: calls `setForegroundNotificationPresentationOptions` so a push that
/// arrives while the app is foregrounded still shows as a heads-up banner
/// (without this, iOS silently delivers to `onMessage` only).
///
/// Android: this helper does NOT create or register any notification channel.
/// Android 8+ will use the system default channel unless the native app
/// declares one via AndroidManifest.xml (meta-data
/// `com.google.firebase.messaging.default_notification_channel_id` + a
/// matching string resource). PR C (or infra follow-up) will add the manifest
/// entry; until then foreground notifications on Android fall back to the
/// OS default channel, which is acceptable for MVP. If we later need several
/// runtime-managed channels we'll introduce `flutter_local_notifications`
/// and register them here.
///
/// Uses `defaultTargetPlatform` (not `dart:io.Platform`) so the file compiles
/// on web — web builds are out of MVP scope but the import must not block
/// compilation of future web work.
Future<void> bootstrapFcmPresentation() async {
  if (kIsWeb) return;
  if (defaultTargetPlatform != TargetPlatform.iOS) return;

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}
