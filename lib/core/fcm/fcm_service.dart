import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../observability/logger.dart';

/// Top-level, grouped handlers for the three FCM lifecycle stages. The
/// actual UI wiring (in-app banner, notification history insert, deep-link
/// on tap) lands in PR B; this file holds the transport-level registration
/// so PR A's main.dart can compile and a dev can verify device tokens.
///
/// Background handlers run in a separate isolate; they must be top-level
/// functions (not class methods), hence the `pragma('vm:entry-point')`.
@pragma('vm:entry-point')
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  // Keep the handler strictly minimal: it runs in an isolate without
  // Riverpod, without Firestore SDK initialised, and with a short deadline.
  // Further handling (history store insert) happens when the app next
  // starts or when the user taps the notification.
  const AppLogger('fcm.bg').info(
    'bg message',
    fields: {'messageId': message.messageId, 'from': message.from},
  );
}

class FcmService {
  FcmService(this._messaging);

  final FirebaseMessaging _messaging;
  static const _logger = AppLogger('fcm');

  /// Register lifecycle handlers + request permission. Call once after
  /// Firebase is initialised and before the first RPC that might register
  /// an FCM token.
  Future<void> start() async {
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((message) {
      _logger.info(
        'fg message',
        fields: {'messageId': message.messageId, 'title': message.notification?.title},
      );
      // TODO(PR B): push into NotificationHistoryStore + surface in-app banner.
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _logger.info(
        'tap message',
        fields: {'messageId': message.messageId},
      );
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
