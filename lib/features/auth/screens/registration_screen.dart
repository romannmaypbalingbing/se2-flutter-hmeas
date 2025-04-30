import 'package:flutter/material.dart';
import 'package:vitawatch/common/widgets/step_progress_indicator.dart';
import 'package:vitawatch/common/widgets/labeled_text_field.dart'; // Make sure to import the LabeledTextField widget

//routing
import 'package:go_router/go_router.dart';
import 'package:vitawatch/features/auth/routes/auth_routes.dart';
import 'package:vitawatch/constants/user_roles.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _PatientRegistrationScreenState();
}

class _PatientRegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  UserRole?
  _selectedUserRole; //used enum; define the variable to store the value for the user

  @override //TODO: find out what this does
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //acess user role
    final Object? extraData = GoRouterState.of(context).extra;

    //check
    if (_selectedUserRole == null && extraData != null) {
      if (extraData is UserRole) {
        _selectedUserRole = extraData;
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Registration',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            fontFamily: 'ClashDisplay',
          ),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Account',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w500,
                fontFamily: 'ClashDisplay',
              ),
            ),
            const Text(
              'Basic Info',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                fontFamily: 'ClashDisplay',
              ),
            ),
            const SizedBox(height: 32),
            const StepProgressIndicator(totalSteps: 5, currentStep: 1),
            const SizedBox(height: 48),

            // Use LabeledTextField for input fields
            LabeledTextField(
              label: 'First Name',
              controller: firstNameController,
            ),
            LabeledTextField(
              label: 'Last Name',
              controller: lastNameController,
            ),
            LabeledTextField(
              label: 'Email',
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            LabeledTextField(
              label: 'Birthday',
              controller: birthdayController,
              keyboardType: TextInputType.datetime,
            ),
            LabeledTextField(label: 'Gender', controller: genderController),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle next action
                },
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

            SizedBox(height: 28),

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
                      'Sign in with Google',
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
                  'Already have an account?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    fontFamily: 'OpenJakartaSans',
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.go(AuthRoutes.login);
                  },
                  child: const Text(
                    'Log In',
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

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    birthdayController.dispose();
    genderController.dispose();
  }
}
