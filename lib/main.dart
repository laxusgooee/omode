import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:omode/firebase_options.dart';
import 'package:go_router/go_router.dart';
import 'package:omode/pages/home_page.dart';
import 'package:omode/pages/auth_page.dart';
import 'package:omode/pages/welcome_page.dart';


final GoRouter _router = GoRouter(
  refreshListenable:
      GoRouterRefreshListenable(FirebaseAuth.instance.authStateChanges()),
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const AuthGate();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'login',
          builder: (BuildContext context, GoRouterState state) {
            return const AuthPage();
          },
        ),
        GoRoute(
          path: 'profile',
          builder: (BuildContext context, GoRouterState state) {
            return ProfileScreen(
              appBar: AppBar(
                title: const Text('User Profile'),
              ),
              actions: [
                SignedOutAction((context) {
                 context.pop();
                })
              ],
              children: const [
                Divider(),
                Padding(
                  padding: EdgeInsets.all(2),
                  child: Text('xxx'),
                ),
              ],
            );
          },
        )
      ]
    ),
  ],
  redirect: (BuildContext context,GoRouterState state) async {
    final user = FirebaseAuth.instance.currentUser;

    const authPaths = [
      '/',
      '/login',
    ];

    if (user != null) {
      if (authPaths.contains(state.fullPath)) {
        return '/';
      }
    } else {
      if (!authPaths.contains(state.fullPath)) {
        return '/';
      }
    }

    return null;
  },
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return PlatformProvider(
      builder: (context) => 
        PlatformTheme(
          builder: (context) => PlatformApp.router(
            localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
              DefaultMaterialLocalizations.delegate,
              DefaultWidgetsLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
            ],
            title: 'Flutter Platform Widgets',
            routerConfig: _router,
        ),
      ),
    );
  }
}


class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const WelcomePage();
        }
        return const HomePage(title: 'Home Page');
      },
    );
  }
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