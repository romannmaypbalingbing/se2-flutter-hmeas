// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vitawatch/features/auth/routes/auth_routes.dart';
import 'package:vitawatch/features/patient/routes/patient_routes.dart';
import 'package:vitawatch/common/widgets/labeled_text_field.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
//add library for error handling >> awesome_snackbar_content.dart

/// Login page for the VitaWatch app.

///  A widget that displays a login screen.
/// Allows users to enter their email and password to log in.
/// Also provides options for password recovery and Google login.
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Log in',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            fontFamily: 'ClashDisplay',
            color: Color(0xFF081C5D),
          ),
        ),
        centerTitle: true,
      ),

      /// Main body of the login screen
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Log in to your',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w500,
                fontFamily: 'ClashDisplay',
                color: Color(0xFF081C5D),
              ),
            ),
            const Text(
              'account',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                fontFamily: 'ClashDisplay',
                color: Color(0xFF081C5D),
              ),
            ),

            const SizedBox(height: 64),

            /// Labeled text fields for email and password input
            LabeledTextField(
              label: 'Email',
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 16),

            LabeledTextField(
              label: 'Password',
              controller: passwordController,
              obscureText: true,
            ),

            /// TODO: add handling for password recovery
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Handle forgot password
                },
                child: const Text(
                  'Forgot password?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2952D9),
                    fontFamily: 'ClashDisplay',
                  ),
                ),
              ),
            ),

            const SizedBox(height: 170),

            // Next button to proceed with login
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  // Get text
                  final email = emailController.text.trim();
                  final password = passwordController.text.trim();

                  // Validate email and password
                  if (email.isEmpty || password.isEmpty) {
                    // Show error message
                    if (!mounted) return;
                    final snackBar = SnackBar(
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: 'Oh Snap!',
                        message: 'Please enter your email and password',
                        contentType: ContentType.failure,
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    return;
                  }

                  try {
                    //Try sign in with email and password
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );

                    if (!mounted) return;
                    context.go(PatientRoutes.dashboard);
                  } on FirebaseAuthException catch (e) {
                    if (!mounted) return;

                    // TODO: fix this error handling; always goes to default case; separate error handling to another file
                    debugPrint(e.toString());

                    final message = switch (e.code) {
                      'user-not-found' => 'No user found for that email.',
                      'The supplied auth credential is incorrect, malformed or has expired.' =>
                        'Wrong password provided for that user.',
                      _ => 'An error occurred. Please try again.',
                    };

                    if (!mounted) return;
                    final snackBar = SnackBar(
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: 'Oh Snap!',
                        message: message,
                        contentType: ContentType.failure,
                      ),
                    );
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }

                  /// add firebase auth here
                },
                //next button
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2952D9),
                  elevation: 7,
                  shadowColor: const Color(0xFF2952D9).withValues(alpha: 0.5),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PlusJakartaSans',
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            //OR divider
            Row(
              children: [
                const Expanded(
                  child: Divider(thickness: 1, color: Colors.grey),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'OR',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                const Expanded(
                  child: Divider(thickness: 1, color: Colors.grey),
                ),
              ],
            ),

            const SizedBox(height: 32),

            //Google Log In Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  // Handle login
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: Colors.blueGrey.withValues(alpha: 0.5),
                    width: 1,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/google_logo.png',
                      height: 24,
                      width: 24,
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Log in with Google',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PlusJakartaSans',
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16),

            //Sign Up Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t have an account?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    fontFamily: 'OpenJakartaSans',
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to sign up screen
                    context.go(AuthRoutes.accountType);
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2952D9),
                      fontFamily: 'ClashDisplay',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //prevent memory leaks ->
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
