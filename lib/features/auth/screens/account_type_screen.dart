import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:vitawatch/common/widgets/step_progress_indicator.dart';

import 'package:go_router/go_router.dart';
import 'package:vitawatch/features/auth/routes/auth_routes.dart';

import 'package:vitawatch/constants/user_roles.dart';

/// This displays the choose account type screen.
class AccountTypeScreen extends StatelessWidget {
  const AccountTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(AuthRoutes.login);
            }
          },
        ),
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

      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Choose your',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w500,
                fontFamily: 'ClashDisplay',
                color: Color(0xFF081C5D),
              ),
            ),
            const Text(
              'account type',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                fontFamily: 'ClashDisplay',
                color: Color(0xFF081C5D),
              ),
            ),

            const SizedBox(height: 48),

            const StepProgressIndicator(totalSteps: 5, currentStep: 0),

            const SizedBox(height: 48),

            //Patient Selection Card
            InkWell(
              onTap: () {
                // navigation to registration screen, with user role 'patient'
                context.push(AuthRoutes.registration, extra: UserRole.patient);
              },
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/patient_icon.png',
                      width: 60.0,
                      height: 60.0,
                    ),
                    const SizedBox(width: 16.0),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Patient',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'ClashDisplay',
                            color: Color(0xFF081C5D),
                          ),
                        ),
                        Text(
                          'Access your health dashboard',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16.0),

            //Guardian Selection Card
            InkWell(
              onTap: () {
                // navigation to registration screen, with user role 'guardian'
                context.push(AuthRoutes.registration, extra: UserRole.guardian);
              },
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/guardian_icon.png',
                      width: 60.0,
                      height: 60.0,
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Guardian',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'ClashDisplay',
                              color: Color(0xFF081C5D),
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            'Stay connected to your loved one’s health and receive alerts in real-time.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                              fontFamily: 'PlusJakartaSans',
                            ),
                            softWrap: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
