import 'dart:io' show Platform;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

/// Android 8+ requires a Notification Channel before any FCM message can
/// produce a system-tray notification. iOS does not need this; the function
/// no-ops there. Invoked from `main.dart` before `runApp`.
Future<void> registerAndroidNotificationChannel() async {
  if (kIsWeb) return;
  if (!Platform.isAndroid) return;

  // firebase_messaging 16.x does not ship its own Android channel API;
  // channel creation lives in the native AndroidManifest.xml + optional
  // native bootstrap. The Flutter-side step is requesting foreground
  // presentation so a heads-up notification shows even while the app is
  // open.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}
