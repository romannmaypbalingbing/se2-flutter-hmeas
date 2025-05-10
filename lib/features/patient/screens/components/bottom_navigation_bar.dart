import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vitawatch/features/patient/routes/patient_routes.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            context.go(PatientRoutes.dashboard);
            break;
          case 1:
            context.go(PatientRoutes.vitalSignsHistory);
            break;
          case 2:
            context.go(PatientRoutes.emergencyAlert);
            break;
          case 3:
            context.go(PatientRoutes.profile);
            break;
        }
      },

      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Vitals'),
        BottomNavigationBarItem(
          icon: Icon(Icons.phone_callback_outlined),
          label: 'Emergency',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
