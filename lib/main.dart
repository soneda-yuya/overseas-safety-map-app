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

  // iOS foreground-banner presentation + any future Android channel setup.
  // Android 8+'s default channel is declared in AndroidManifest.xml, so the
  // Dart side currently only has work to do on iOS.
  await bootstrapFcmPresentation();

  runApp(const ProviderScope(child: OverseasSafetyMapApp()));
}
