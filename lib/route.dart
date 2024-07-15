import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:go_router/go_router.dart';
import 'package:omode/pages/alphabets_page.dart';
import 'package:omode/pages/home_page.dart';
import 'package:omode/pages/auth_page.dart';
import 'package:omode/pages/numbers_page.dart';
import 'package:omode/pages/shapes_page.dart';
import 'package:omode/pages/welcome_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    refreshListenable:
        GoRouterRefreshListenable(FirebaseAuth.instance.authStateChanges()),
    routes: <RouteBase>[
      GoRoute(
        path: '/auth',
        builder: (BuildContext context, GoRouterState state) {
          return const WelcomePage();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'login',
            builder: (BuildContext context, GoRouterState state) {
              return const AuthPage();
            },
          ),
        ]
      ),
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return HomePage();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'numbers',
            builder: (BuildContext context, GoRouterState state) {
              return NumbersPage();
            },
          ),
          GoRoute(
            path: 'alphabets',
            builder: (BuildContext context, GoRouterState state) {
              return AlphabetsPage();
            },
          ),
          GoRoute(
            path: 'shapes',
            builder: (BuildContext context, GoRouterState state) {
              return ShapesPage();
            },
          ),
        ],
      ),
    ],
    redirect: (BuildContext context,GoRouterState state) async {
      final user = FirebaseAuth.instance.currentUser;

      const authPaths = [
        '/auth',
        '/auth/login',
      ];

      if (user != null) {
        if (authPaths.contains(state.fullPath)) {
          return '/';
        }
      } else {
        if (!authPaths.contains(state.fullPath)) {
          return '/auth';
        }
      }

      return null;
    },
  );
}

class GoRouterRefreshListenable extends ChangeNotifier {
  GoRouterRefreshListenable(Stream stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (_) {
        notifyListeners();
      },
    );
  }

  late final StreamSubscription _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}