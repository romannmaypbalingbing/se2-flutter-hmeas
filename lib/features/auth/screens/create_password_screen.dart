import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vitawatch/common/widgets/labeled_text_field.dart';
import 'package:vitawatch/common/widgets/step_progress_indicator.dart';
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
              // add error screen
            }
          },
        ),
        title: const Text(
          'Patient Registration',
          style: TextStyle(
            color: Colors.black,
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
              ),
            ),
            const Text(
              'password',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                fontFamily: 'ClashDisplay',
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'lorem ipsum dolor sit amet',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
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
                null; // Replace with your navigation logic
              },
              child: const Text(
                'Next',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'OpenJakartaSans',
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
