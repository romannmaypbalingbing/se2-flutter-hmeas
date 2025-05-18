import 'package:vitawatch/features/patient/screens/components/line_chart_main.dart';
import 'package:vitawatch/features/patient/screens/components/bottom_navigation_bar.dart';
import 'package:vitawatch/features/patient/screens/components/device_status.dart';
import 'package:vitawatch/features/patient/screens/components/vital_sign_cards.dart';
import 'package:sliding_action_button/sliding_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vitawatch/common/providers/vital_service_provider.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final vitalsAsync = ref.watch(vitalStreamProvider);

    return vitalsAsync.when(
      data: (vitalsList) {
        if (vitalsList.isEmpty) {
          return const Center(child: Text('No vital data available'));
        }

        final latest = vitalsList.first;

        final temperature = latest['temperature']?.toString() ?? 'N/A';
        final spo2 = latest['spo2']?.toString() ?? 'N/A';
        final heartRate = latest['heart_rate']?.toString() ?? 'N/A';
        final bloodPressure = latest['blood_pressure']?.toString() ?? 'N/A';

        final List<Map<String, String>> vitalData = [
          {'label': 'Temperature', 'value': '$temperature °C'},
          {'label': 'SPO2', 'value': '$spo2 %'},
          {'label': 'Heart Rate', 'value': '$heartRate bpm'},
        ];

        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 24,
                  ),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top bar icons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(Icons.menu, color: Colors.white),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.notifications,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Grid style layout: Left Column + Right Column
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // LEFT COLUMN
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Hi, User!',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontFamily: 'ClashDisplay',
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Text(
                                      'Your vital signs are ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.greenAccent,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Text(
                                        'stable',
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),

                                // Scan Now Button
                                SizedBox(
                                  height: 30,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF7893FF),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 50,
                                        vertical: 5,
                                      ),
                                    ),
                                    child: const Text(
                                      'scan now',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        fontFamily: 'ClashDisplay',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),

                          // DEVICE_STATUS
                          const DeviceStatus(
                            connected: true,
                            batteryLevel: 85,
                            connectionType: 'Wi-Fi',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Pass the full vitalsList for the chart
                LineChartMain(vitalsList: vitalsList),

                const SizedBox(height: 10),

                // Pass the latest vitalData to the cards
                VitalSignCards(vitalData: vitalData),

                const SizedBox(height: 20),

                // Slide to action button
                SquareSlideToActionButton(
                  width: 375,
                  height: 80,
                  parentBoxRadiusValue: 15,
                  initialSlidingActionLabel: 'Alert Guardian',
                  finalSlidingActionLabel: 'Alerted',
                  squareSlidingButtonSize: 70,
                  squareSlidingButtonIcon: const Icon(
                    Icons.warning,
                    color: Color(0xFF081C5D),
                  ),
                  squareSlidingButtonBackgroundColor: Colors.white,
                  parentBoxGradientBackgroundColor: const LinearGradient(
                    colors: [
                      Color(0xFF2952D9),
                      Color.fromARGB(255, 167, 195, 255),
                    ],
                  ),
                  parentBoxDisableGradientBackgroundColor: const LinearGradient(
                    colors: [Colors.grey],
                  ),
                  leftEdgeSpacing: 6,
                  rightEdgeSpacing: 6,
                  onSlideActionCompleted: () {
                    // You probably want to do something here
                    debugPrint("Sliding action completed");
                  },
                  onSlideActionCanceled: () {
                    debugPrint("Sliding action cancelled");
                  },
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
          ),
        );
      },

      loading: () => const Center(child: CircularProgressIndicator()),

      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
