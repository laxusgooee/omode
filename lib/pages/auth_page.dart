import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignInScreen(
        providers: [
          EmailAuthProvider(),
          GoogleProvider(clientId: "308381275742-t10srufdeogbagmbk837nva0auuvt1b1.apps.googleusercontent.com"),
        ],
      ),
    );
  }
}
