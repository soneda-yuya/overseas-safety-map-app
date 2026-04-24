import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// IdTokenProvider is the narrow port that [AuthInterceptor] depends on.
/// Keeping it as a named interface lets tests swap in a deterministic token
/// source without booting Firebase.
abstract class IdTokenProvider {
  /// Returns a Firebase ID Token. Pass `forceRefresh: true` to bypass the
  /// SDK cache (the AuthInterceptor uses this on every RPC so a near-expiry
  /// token is never handed to the server). Returns null if the user is not
  /// signed in.
  Future<String?> currentIdToken({bool forceRefresh = false});
}

/// Firebase-backed implementation. Signs the user in anonymously on first
/// access so the app is usable without a user-visible sign-in flow (US-07).
class FirebaseIdTokenProvider implements IdTokenProvider {
  FirebaseIdTokenProvider(this._auth);

  final FirebaseAuth _auth;

  @override
  Future<String?> currentIdToken({bool forceRefresh = false}) async {
    final user = _auth.currentUser ?? (await _auth.signInAnonymously()).user;
    return user?.getIdToken(forceRefresh);
  }
}

/// Riverpod wiring. `firebaseAuthProvider` exists as its own provider so
/// tests can override a single leaf without touching [idTokenProvider].
final firebaseAuthProvider = Provider<FirebaseAuth>(
  (ref) => FirebaseAuth.instance,
);

final idTokenProvider = Provider<IdTokenProvider>(
  (ref) => FirebaseIdTokenProvider(ref.watch(firebaseAuthProvider)),
);

/// Broadcast of auth state. UI gates (SplashScreen → home) watch this to
/// decide when Firebase has finished bootstrapping.
final authStateProvider = StreamProvider<User?>(
  (ref) => ref.watch(firebaseAuthProvider).authStateChanges(),
);
