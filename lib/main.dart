// This file is the main entry point of the Flutter application.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:vitawatch/app.dart';

void main() async {
  //initialize firebase app
  // This is required to ensure that the Flutter engine is initialized before using any Firebase services.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}
