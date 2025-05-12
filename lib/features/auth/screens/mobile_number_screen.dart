import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vitawatch/common/widgets/step_progress_indicator.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:vitawatch/features/auth/routes/auth_routes.dart';
import 'package:vitawatch/features/auth/providers/auth_providers.dart';
import 'package:vitawatch/features/auth/services/auth_service.dart';
import 'package:vitawatch/features/auth/providers/auth_state_notifier.dart';

class MobileNumberScreen extends StatefulWidget {
  const MobileNumberScreen({super.key});

  @override
  State<MobileNumberScreen> createState() => _MobileNumberScreenState();
}

class _MobileNumberScreenState extends State<MobileNumberScreen> {
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
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
                color: Color(0xFF081C5D),
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
                  'Enter your',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'ClashDisplay',
                    color: Color(0xFF081C5D),
                  ),
                ),
                const Text(
                  'mobile number',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'ClashDisplay',
                    color: Color(0xFF081C5D),
                  ),
                ),

                const SizedBox(height: 48),
                const StepProgressIndicator(totalSteps: 4, currentStep: 2),
                const SizedBox(height: 48),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Country code container with flag
                          // TODO: add country code picker
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              // color: const Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade400),
                            ),
                            child: Row(
                              children: [
                                // 🇵🇭 Flag image (make sure it's in your assets)
                                SvgPicture.asset(
                                  'assets/images/ph_flag_icon.svg', // adjust path if needed
                                  width: 24,
                                  height: 16,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  '+63',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'PlusJakartaSans',
                                    color: Colors.black87,
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_drop_down,
                                  color: Color(0xFF2952D9),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 12),

                          // Mobile number input
                          Expanded(
                            child: TextFormField(
                              controller: phoneNumberController,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'PlusJakartaSans',
                                  color: Colors.grey,
                                ),
                                border: UnderlineInputBorder(),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF081C5D),
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            final mobileNumber =
                                phoneNumberController.text.trim();

                            if (mobileNumber.isEmpty ||
                                mobileNumber.length < 10) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: AwesomeSnackbarContent(
                                    title: 'Error',
                                    message:
                                        'Please enter a valid mobile number',
                                    contentType: ContentType.failure,
                                  ),
                                ),
                              );
                              return;
                            }

                            final registrationData =
                                ref
                                    .read(registrationDataProvider.notifier)
                                    .state;
                            ref
                                .read(registrationDataProvider.notifier)
                                .state = {
                              ...registrationData,
                              'phoneNumber': mobileNumber,
                            };
                            debugPrint(
                              'Registration data: ${registrationData.toString()}',
                            );

                            context.push(AuthRoutes.dashboard);

                            // Call the Firebase email/password sign-up method
                            final authService = ref.read(authServiceProvider);
                            try {
                              // Attempt to register the user using email and password
                              UserCredential userCredential = await authService
                                  .signUpWithEmailPassword(
                                    registrationData['email'],
                                    registrationData['password'],
                                    registrationData['firstName'],
                                    registrationData['lastName'],
                                    registrationData['birthday'],
                                    registrationData['sex'],
                                    mobileNumber,
                                    registrationData['role'],
                                  );

                              // You can access userCredential.user to get user details
                              debugPrint(
                                "User created: ${userCredential.user?.email}",
                              );

                              // Navigate to the next screen or dashboard
                              if (!context.mounted) return;
                              context.push(AuthRoutes.dashboard);
                            } catch (e) {
                              // Handle any errors that occur during the sign-up process
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: AwesomeSnackbarContent(
                                    title: 'Error',
                                    message: 'Failed to create account: $e',
                                    contentType: ContentType.failure,
                                  ),
                                ),
                              );
                            }

                            // final authService = ref.read(authServiceProvider);

                            // await FirebaseAuth.instance.verifyPhoneNumber(
                            //   phoneNumber: '+63$mobileNumber',
                            //   verificationCompleted: (
                            //     PhoneAuthCredential credential,
                            //   ) async {
                            //     await FirebaseAuth.instance
                            //         .signInWithCredential(credential);
                            //   },
                            //   verificationFailed: (FirebaseAuthException e) {
                            //     ScaffoldMessenger.of(context).showSnackBar(
                            //       SnackBar(
                            //         content: AwesomeSnackbarContent(
                            //           title: 'Error',
                            //           message:
                            //               'Verification failed: ${e.message}',
                            //           contentType: ContentType.failure,
                            //         ),
                            //       ),
                            //     );
                            //   },
                            //   codeSent: (
                            //     String verificationId,
                            //     int? resendToken,
                            //   ) {
                            //     ref
                            //         .read(verificationIDProvider.notifier)
                            //         .state = verificationId;
                            //     ref
                            //         .read(registrationDataProvider.notifier)
                            //         .state = {
                            //       ...ref.read(registrationDataProvider),
                            //       'phoneNumber': mobileNumber,
                            //     };
                            //     context.push(AuthRoutes.verifyOTP);
                            //   },
                            //   codeAutoRetrievalTimeout: (
                            //     String verificationId,
                            //   ) {
                            //     ref
                            //         .read(verificationIDProvider.notifier)
                            //         .state = verificationId;
                            //   },
                            //   timeout: const Duration(seconds: 60),
                            // );
                          },

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
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
