import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vitawatch/features/auth/routes/auth_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    // Simulate a delay for the splash screen
    await Future.delayed(const Duration(seconds: 3));

    // Navigate to the login screen after the delay
    if (mounted) {
      context.go(AuthRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    //UI starts here
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/vitawatch_logo.png',
                    width: 300,
                    height: 300,
                  ),
                  const SizedBox(height: 20),
                  const CircularProgressIndicator(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: const [
                Text(
                  'A Software Engineering 2 Project',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.blueGrey,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
                Text(
                  'BSCS - 3C',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.blueGrey,
                    fontFamily: 'Plus Jakarta Sans',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
