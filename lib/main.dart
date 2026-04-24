// Entry point for the overseas-safety-map Flutter client (U-APP). The actual
// app shell (go_router + theme + feature screens) lives in [app.dart]; this
// file only wires Firebase and ProviderScope before runApp.
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/fcm/notification_channel.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase must be ready before any Riverpod provider that reads auth /
  // messaging state spins up.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Configure FCM foreground presentation where the Dart side can —
  // currently only on iOS. Android 8+ falls back to the OS default channel
  // unless AndroidManifest.xml is extended with
  // `com.google.firebase.messaging.default_notification_channel_id`;
  // see notification_channel.dart for the tracking note.
  await bootstrapFcmPresentation();

  runApp(const ProviderScope(child: OverseasSafetyMapApp()));
}
