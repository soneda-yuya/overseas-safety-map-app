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
/// Android: the Android 8+ Notification Channel is declared in the native
/// Flutter module's AndroidManifest.xml (`default_notification_channel_id`);
/// no runtime call is required from Dart for the default channel. If we add
/// multiple channels later we'll introduce `flutter_local_notifications` and
/// register them here.
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
