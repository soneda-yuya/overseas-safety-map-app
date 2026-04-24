import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/splash_screen.dart';
import '../../features/incidents/presentation/detail_screen.dart';
import '../../features/incidents/presentation/list_screen.dart';
import '../../features/map/presentation/map_screen.dart';
import '../../features/notifications/presentation/notification_history_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../auth/anonymous_auth.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final refresh = _AuthRefresh(ref);
  final router = GoRouter(
    initialLocation: '/map',
    redirect: (context, state) {
      final auth = ref.read(authStateProvider);
      // While Firebase is still initialising the stream has no value yet;
      // send the user to /splash so we don't render a tab whose data
      // providers would immediately fail the auth interceptor.
      // The originally requested location is preserved in a `from` query
      // param so deep links (e.g. a notification tap opening
      // /incidents/detail/:keyCd) survive the sign-in round-trip.
      final loggedIn = auth.asData?.value != null;
      if (!loggedIn && state.matchedLocation != '/splash') {
        final from = Uri.encodeComponent(state.uri.toString());
        return '/splash?from=$from';
      }
      if (loggedIn && state.matchedLocation == '/splash') {
        final from = state.uri.queryParameters['from'];
        if (from != null && from.isNotEmpty) {
          return Uri.decodeComponent(from);
        }
        return '/map';
      }
      return null;
    },
    refreshListenable: refresh,
    routes: [
      GoRoute(path: '/splash', builder: (_, _) => const SplashScreen()),
      ShellRoute(
        builder: (context, state, child) => _RootScaffold(child: child),
        routes: [
          GoRoute(path: '/map', builder: (_, _) => const MapScreen()),
          GoRoute(
            path: '/incidents',
            builder: (_, _) => const ListScreen(),
            routes: [
              GoRoute(
                path: 'detail/:keyCd',
                builder: (_, state) =>
                    DetailScreen(keyCd: state.pathParameters['keyCd']!),
              ),
            ],
          ),
          GoRoute(
            path: '/notifications',
            builder: (_, _) => const NotificationHistoryScreen(),
          ),
          GoRoute(path: '/profile', builder: (_, _) => const ProfileScreen()),
        ],
      ),
    ],
  );
  // Release the GoRouter + its ChangeNotifier when this provider is torn
  // down (hot reload, test override, future refactor). Without this the
  // Firebase auth subscription in _AuthRefresh leaks.
  ref.onDispose(() {
    router.dispose();
    refresh.dispose();
  });
  return router;
});

/// Drives go_router's `refreshListenable` off the Firebase auth state. Every
/// emission triggers a redirect re-evaluation so the user is pushed from
/// /splash → /map (or back) without manual navigation.
class _AuthRefresh extends ChangeNotifier {
  _AuthRefresh(Ref ref) {
    _sub = ref.listen(authStateProvider, (_, _) => notifyListeners());
  }

  late final ProviderSubscription<AsyncValue<User?>> _sub;

  @override
  void dispose() {
    _sub.close();
    super.dispose();
  }
}

/// Root scaffold shown for every tab route. Provides the bottom nav and
/// routes between /map / /incidents / /notifications / /profile.
class _RootScaffold extends StatelessWidget {
  const _RootScaffold({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final index = _indexForLocation(location);

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.public), label: '地図'),
          NavigationDestination(icon: Icon(Icons.list), label: '一覧'),
          NavigationDestination(
            icon: Icon(Icons.notifications_outlined),
            selectedIcon: Icon(Icons.notifications),
            label: '通知',
          ),
          NavigationDestination(icon: Icon(Icons.settings), label: '設定'),
        ],
        onDestinationSelected: (i) => _onTap(context, i),
      ),
    );
  }

  int _indexForLocation(String location) {
    if (location.startsWith('/map')) return 0;
    if (location.startsWith('/incidents')) return 1;
    if (location.startsWith('/notifications')) return 2;
    if (location.startsWith('/profile')) return 3;
    return 0;
  }

  void _onTap(BuildContext context, int i) {
    const routes = ['/map', '/incidents', '/notifications', '/profile'];
    context.go(routes[i]);
  }
}
