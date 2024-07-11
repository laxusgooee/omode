import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:omode/app.dart';
import 'package:omode/firebase_options.dart';

GetIt getIt = GetIt.instance;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}
