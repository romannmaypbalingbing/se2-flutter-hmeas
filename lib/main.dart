// This file is the main entry point of the Flutter application.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vitawatch/app.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}
