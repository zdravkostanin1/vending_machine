import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vending_machine_task/firebase_options.dart';
import 'package:vending_machine_task/src/views/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// initialize firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const App());
}