import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../observability/logger.dart';

/// Top-level background message handler. Runs in a separate isolate, so
/// it must be a top-level function (not a class method) and registered via
/// `FirebaseMessaging.onBackgroundMessage(...)` **before `runApp`** to
/// reliably receive background pushes. See `main.dart` for the call.
///
/// Keep the handler strictly minimal: it runs without Riverpod, without
/// Firestore SDK initialised, and under a short deadline. Further
/// processing (history store insert) happens when the app next starts or
/// when the user taps the notification.
@pragma('vm:entry-point')
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  const AppLogger('fcm.bg').info(
    'bg message',
    fields: {'messageId': message.messageId, 'from': message.from},
  );
}

class FcmService {
  FcmService(this._messaging);

  final FirebaseMessaging _messaging;
  static const _logger = AppLogger('fcm');

  /// Register foreground / tap listeners + request permission. Call once
  /// after Firebase is initialised and before the first RPC that might
  /// register an FCM token. The background-message handler is registered
  /// separately in `main.dart` before `runApp`; it has to happen there so
  /// the isolate entry point is set up when a push arrives while the app
  /// is not running.
  Future<void> start() async {
    await _messaging.requestPermission(alert: true, badge: true, sound: true);

    FirebaseMessaging.onMessage.listen((message) {
      _logger.info(
        'fg message',
        fields: {
          'messageId': message.messageId,
          'title': message.notification?.title,
        },
      );
      // TODO(PR B): push into NotificationHistoryStore + surface in-app banner.
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _logger.info('tap message', fields: {'messageId': message.messageId});
      // TODO(PR B): deep-link into DetailScreen via go_router.
    });
  }

  /// Current device FCM token. Used by RegisterFcmTokenUseCase (PR B).
  Future<String?> currentToken() => _messaging.getToken();
}

final firebaseMessagingProvider = Provider<FirebaseMessaging>(
  (ref) => FirebaseMessaging.instance,
);

final fcmServiceProvider = Provider<FcmService>(
  (ref) => FcmService(ref.watch(firebaseMessagingProvider)),
);
