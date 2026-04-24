import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// IdTokenProvider is the narrow port that [AuthClientInterceptor] depends
/// on. Keeping it as a named interface lets tests swap in a deterministic
/// token source without booting Firebase.
abstract class IdTokenProvider {
  /// Returns a Firebase ID token. Default behaviour relies on the Firebase
  /// Auth SDK cache: the SDK auto-refreshes when a token is within ~5
  /// minutes of expiry, so ordinary RPC call sites do not need to force a
  /// refresh. Pass `forceRefresh: true` to bypass that cache and mint a
  /// brand-new token (useful for surfacing backend revocation immediately).
  /// Returns null if the user is not signed in.
  Future<String?> currentIdToken({bool forceRefresh = false});
}

/// Firebase-backed implementation. Signs the user in anonymously on first
/// access so the app is usable without a user-visible sign-in flow (US-07).
class FirebaseIdTokenProvider implements IdTokenProvider {
  FirebaseIdTokenProvider(this._auth);

  final FirebaseAuth _auth;

  /// In-flight anonymous sign-in Future. At startup multiple providers can
  /// call `currentIdToken` in parallel; without this memo each would trigger
  /// its own `signInAnonymously`, producing duplicate anonymous users and
  /// a racey auth state. Serialise on the first caller and share the Future
  /// with everyone else.
  Future<UserCredential>? _pendingSignIn;

  @override
  Future<String?> currentIdToken({bool forceRefresh = false}) async {
    final user = await _currentOrSignInAnonymously();
    return user?.getIdToken(forceRefresh);
  }

  Future<User?> _currentOrSignInAnonymously() async {
    final existing = _auth.currentUser;
    if (existing != null) return existing;

    final future = _pendingSignIn ??= _auth.signInAnonymously();
    try {
      return (await future).user;
    } finally {
      // Clear only if no one swapped a new in-flight Future in while we
      // awaited; this is safe because we're single-threaded on this path.
      if (identical(_pendingSignIn, future)) {
        _pendingSignIn = null;
      }
    }
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
