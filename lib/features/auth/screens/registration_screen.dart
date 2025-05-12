import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vitawatch/common/widgets/step_progress_indicator.dart';
import 'package:vitawatch/common/widgets/labeled_text_field.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
//routing
import 'package:go_router/go_router.dart';
import 'package:vitawatch/features/auth/routes/auth_routes.dart';
import 'package:vitawatch/constants/user_roles.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vitawatch/features/auth/providers/auth_providers.dart';

/// A screen for user registration.
/// It includes input fields for first name, last name, email, birthday, and sex

class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({super.key});

  @override
  ConsumerState<RegistrationScreen> createState() =>
      _PatientRegistrationScreenState();
}

class _PatientRegistrationScreenState
    extends ConsumerState<RegistrationScreen> {
  //create a global key used to access the formstate to validate the form
  final _formKey = GlobalKey<FormState>();
  // controllers for the text fields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController sexController = TextEditingController();

  bool _isLoading = false; //used to check if the app is loading
  String? _error; //used to check if there is an error
  UserRole?
  _selectedUserRole; //used enum; define the variable to store the value for the user
  String? selectedsex; //used to store the selected sex

  @override
  void initState() {
    super.initState();
  }

  void _onNextPressed() async {
    if (!_formKey.currentState!.validate())
      return; // Validate the form and show error messages if any field is invalid

    if (_selectedUserRole == null) {
      setState(() => _error = 'Please select a user role');
      return;
    }
    setState(() {
      _isLoading = true;
      _error = null;
    }); // Set loading state to true

    try {
      final registrationData = {
        'firstName': firstNameController.text.trim(),
        'lastName': lastNameController.text.trim(),
        'email': emailController.text.trim(),
        'birthday': birthdayController.text.trim(),
        'sex': sexController.text.trim(),
        'role': _selectedUserRole?.name,
        'phoneNumber': '',
        'password': '',
      };

      ref.read(registrationDataProvider.notifier).state =
          registrationData; // Store the registration data in the provider
      debugPrint('Registration data: ${registrationData.toString()}');

      setState(() => _isLoading = false); // Set loading state to false

      if (!mounted) return; // Check if the widget is still mounted
      context.push(AuthRoutes.createPassword);
    } catch (e) {
      _error = e.toString();
      debugPrint('Registration error: $_error');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false); // Set loading state to false
      }
    }
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
              const SizedBox(height: 24),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      LabeledTextField(
                        label: 'First Name',
                        controller: firstNameController,
                        validator:
                            (value) => value!.isEmpty ? 'Required' : null,
                      ),
                      const SizedBox(height: 8),
                      LabeledTextField(
                        label: 'Last Name',
                        controller: lastNameController,
                        validator:
                            (value) => value!.isEmpty ? 'Required' : null,
                      ),
                      const SizedBox(height: 8),
                      LabeledTextField(
                        label: 'Email',
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator:
                            (value) => value!.isEmpty ? 'Required' : null,
                      ),
                      const SizedBox(height: 8),
                      // Birthday Picker
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Birthday',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'ClashDisplay',
                              color: Color(0xFF081C5D),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              DatePicker.showDatePicker(
                                context,
                                showTitleActions: true,
                                minTime: DateTime(1900),
                                maxTime: DateTime.now(),
                                onConfirm: (date) {
                                  setState(() {
                                    birthdayController.text =
                                        date.toIso8601String().split('T')[0];
                                  });
                                },
                                currentTime: DateTime.now().subtract(
                                  Duration(days: 365 * 18),
                                ),
                                locale: LocaleType.en,
                              );
                            },
                            child: AbsorbPointer(
                              child: TextFormField(
                                controller: birthdayController,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'PlusJakartaSans',
                                  color: Colors.black,
                                ),
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Sex Dropdown
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Sex',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'ClashDisplay',
                              color: Color(0xFF081C5D),
                            ),
                          ),
                          DropdownButtonFormField<String>(
                            value: selectedsex,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedsex = newValue!;
                                sexController.text = newValue;
                              });
                            },
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF081C5D),
                                  width: 1.5,
                                ),
                              ),
                            ),
                            items:
                                ['Male', 'Female', 'Other']
                                    .map(
                                      (sex) => DropdownMenuItem<String>(
                                        value: sex,
                                        child: Text(
                                          sex,
                                          style: const TextStyle(
                                            fontFamily: 'OpenJakartaSans',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // NEXT BUTTON
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _onNextPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2952D9),
                            elevation: 7,
                            shadowColor: const Color(
                              0xFF2952D9,
                            ).withValues(alpha: 0.5),
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
                              if (!context.mounted) return;
                              context.go(AuthRoutes.dashboard);
                            } on FirebaseAuthException catch (e) {
                              if (!context.mounted) return;
                              showDialog(
                                context: context,
                                builder:
                                    (context) => AlertDialog(
                                      title: const Text("Sign-up failed"),
                                      content: Text(
                                        e.message ?? 'Unknown error',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed:
                                              () => Navigator.of(context).pop(),
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
    sexController.dispose();
    super.dispose();
  }
}
