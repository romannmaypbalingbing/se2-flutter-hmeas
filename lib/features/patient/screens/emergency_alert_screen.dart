import 'package:flutter/material.dart';
import 'package:sliding_action_button/sliding_action_button.dart';
import 'package:vitawatch/features/patient/screens/components/bottom_navigation_bar.dart';

class EmergencyAlertScreen extends StatefulWidget {
  const EmergencyAlertScreen({super.key});

  @override
  State<EmergencyAlertScreen> createState() => _EmergencyAlertScreenState();
}

class _EmergencyAlertScreenState extends State<EmergencyAlertScreen> {
  int _currentIndex = 2;

  final List<Map<String, dynamic>> contacts = [
    {
      'name': 'John S. Doe',
      'subtitle': 'Guardian',
      'status': 'online–in-app',
      'phone': '<0912 3456 7891>',
      'alerted': true,
    },
    {
      'name': 'ABC HOSPITAL',
      'subtitle': 'primary emergency dial',
      'phone': '<0912 3456 7891>',
      'alerted': false,
    },
    {
      'name': 'Barangay Emergency Responders',
      'subtitle': 'primary emergency dial',
      'phone': '<0912 3456 7891>',
      'alerted': true,
    },
    {
      'name': 'National Emergency Hotline',
      'subtitle': 'primary emergency dial',
      'phone': '911',
      'alerted': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF081C5D),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // Gradient background
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 260,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF081C5D), Color(0xFF2952D9)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
              ),
            ),

            // Foreground content
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top bar
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 24,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(Icons.arrow_back, color: Colors.white),
                      Text(
                        'Edit',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),

                // // Slide to action
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 20),
                //   child: SquareSlideToActionButton(
                //     width: double.infinity,
                //     height: 80,
                //     parentBoxRadiusValue: 15,
                //     initialSlidingActionLabel: 'Swipe right to trigger alert',
                //     finalSlidingActionLabel: 'Alerted',
                //     squareSlidingButtonSize: 70,
                //     squareSlidingButtonIcon: const Icon(
                //       Icons.warning,
                //       color: Color(0xFF081C5D),
                //     ),
                //     squareSlidingButtonBackgroundColor: Colors.white,
                //     parentBoxGradientBackgroundColor: const LinearGradient(
                //       colors: [
                //         Color(0xFF2952D9),
                //         Color.fromARGB(255, 167, 195, 255),
                //       ],
                //     ),
                //     parentBoxDisableGradientBackgroundColor:
                //         const LinearGradient(colors: [Colors.grey]),
                //     leftEdgeSpacing: 6,
                //     rightEdgeSpacing: 6,
                //     onSlideActionCompleted: () {
                //       debugPrint("Sliding action completed");
                //     },
                //     onSlideActionCanceled: () {
                //       debugPrint("Sliding action cancelled");
                //     },
                //   ),
                // ),
                const SizedBox(height: 24),

                // Guardian label
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Hot Dials',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'ClashDisplay',
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Contact cards
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      final contact = contacts[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              contact['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(contact['subtitle']),
                                    if (contact['status'] != null)
                                      Text(
                                        contact['status'],
                                        style: const TextStyle(
                                          color: Colors.green,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                  ],
                                ),
                                Text(
                                  contact['phone'],
                                  style: const TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                            if (contact['alerted'] == true)
                              const Padding(
                                padding: EdgeInsets.only(top: 4),
                                child: Text(
                                  'alerted first when emergency triggered',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black38,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
