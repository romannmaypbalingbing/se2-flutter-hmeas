import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vitawatch/common/widgets/step_progress_indicator.dart';
import 'package:vitawatch/common/widgets/labeled_text_field.dart'; // Make sure to import the LabeledTextField widget

//routing
import 'package:go_router/go_router.dart';
import 'package:vitawatch/features/auth/routes/auth_routes.dart';
import 'package:vitawatch/constants/user_roles.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vitawatch/features/auth/providers/auth_providers.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({super.key});

  @override
  ConsumerState<RegistrationScreen> createState() =>
      _PatientRegistrationScreenState();
}

class _PatientRegistrationScreenState
    extends ConsumerState<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>(); //used to validate the form

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  bool _isLoading = false; //used to check if the app is loading
  String? _error; //used to check if there is an error
  UserRole?
  _selectedUserRole; //used enum; define the variable to store the value for the user

  @override //TODO: find out what this does
  void initState() {
    super.initState();
  }

  void _onNextPressed() async {
    if (!_formKey.currentState!.validate()) {
      return; // If the form is not valid, do not proceed
    }
    setState(() => _isLoading = true); // Set loading state to true

    final registrationData = {
      'firstName': firstNameController.text.trim(),
      'lastName': lastNameController.text.trim(),
      'email': emailController.text.trim(),
      'birthday': birthdayController.text.trim(),
      'gender': genderController.text.trim(),
      'role': _selectedUserRole?.name,
    };

    ref.read(registrationDataProvider.notifier).state =
        registrationData; // Store the registration data in the provider

    setState(() => _isLoading = false); // Set loading state to false

    if (!mounted) return; // Check if the widget is still mounted
    context.go(AuthRoutes.createPassword);
  }

  @override
  Widget build(BuildContext context) {
    //acess user role
    final extraData = GoRouterState.of(context).extra;

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
        child: Form(
          key: _formKey,

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
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 8),
              LabeledTextField(
                label: 'Last Name',
                controller: lastNameController,
              ),
              const SizedBox(height: 8),
              LabeledTextField(
                label: 'Email',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 8),
              LabeledTextField(
                label: 'Birthday',
                controller: birthdayController,
                keyboardType: TextInputType.datetime,
              ),
              const SizedBox(height: 8),
              LabeledTextField(label: 'Gender', controller: genderController),

              const SizedBox(height: 32),

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

              //Google Signup Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () async {
                    // Handle signup
                    final authService = ref.read(authServiceProvider);
                    try {
                      final userCredential =
                          await authService.signInWithGoogle();
                      debugPrint(
                        'User signed up: ${userCredential.user?.email}',
                      );
                      // Navigate to the next screen after successful signup
                      if (!mounted) return;
                      context.go(AuthRoutes.dashboard);
                    } on FirebaseAuthException catch (e) {
                      if (!mounted) return;
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              title: const Text("Sign-up failed"),
                              content: Text(e.message ?? 'Unknown error'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                      );
                    }
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
    super.dispose();
  }
}
