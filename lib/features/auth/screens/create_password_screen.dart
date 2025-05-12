import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart'; // Import the package
import 'package:go_router/go_router.dart';
import 'package:vitawatch/common/widgets/labeled_text_field.dart';
import 'package:vitawatch/common/widgets/step_progress_indicator.dart';
import 'package:vitawatch/features/auth/providers/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vitawatch/features/auth/routes/auth_routes.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Wrap the build method with Consumer
    return Consumer(
      builder: (context, ref, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  // Add error screen if necessary
                }
              },
            ),
            title: const Text(
              'Patient Registration',
              style: TextStyle(
                color: Color(0xFF081C5D),
                fontSize: 16,
                fontFamily: 'ClashDisplay',
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                const Text(
                  'Create your',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'ClashDisplay',
                    color: Color(0xFF081C5D),
                  ),
                ),
                const Text(
                  'password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'ClashDisplay',
                    color: Color(0xFF081C5D),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Please create a password to secure your account.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'OpenJakartaSans',
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 24),
                const StepProgressIndicator(totalSteps: 5, currentStep: 4),
                const SizedBox(height: 48),
                LabeledTextField(
                  controller: passwordController,
                  label: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                LabeledTextField(
                  controller: confirmPasswordController,
                  label: 'Re-type your password',
                  obscureText: true,
                ),
                const Spacer(),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: const Color(0xFF2952D9),
                    elevation: 4,
                  ),
                  onPressed: () {
                    if (passwordController.text !=
                        confirmPasswordController.text) {
                      // Show error message using AwesomeSnackbarContent
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: AwesomeSnackbarContent(
                            title: 'Error',
                            message: 'Passwords do not match!',
                            contentType: ContentType.failure, // Red error icon
                          ),
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                      );
                    } else if (passwordController.text.isEmpty) {
                      // Show error message using AwesomeSnackbarContent
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: AwesomeSnackbarContent(
                            title: 'Error',
                            message: 'Password cannot be empty!',
                            contentType: ContentType.failure, // Red error icon
                          ),
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                      );
                    } else {
                      // Passwords match and are valid, so update the registration data
                      final registrationData =
                          ref.read(registrationDataProvider.notifier).state;
                      ref.read(registrationDataProvider.notifier).state = {
                        ...registrationData,
                        'password': passwordController.text.trim(),
                      };

                      // Navigate to the next screen or step
                      context.push(AuthRoutes.mobileNumber);
                    }
                  },
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontFamily: 'OpenJakartaSans',
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }
}
