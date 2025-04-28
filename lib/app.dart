import 'package:flutter/material.dart';
import 'package:vitawatch/routes/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,
      title: 'VitaWatch',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
    );
  }
}
