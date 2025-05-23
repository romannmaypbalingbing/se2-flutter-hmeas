// import 'package:vitawatch/features/patient/screens/components/settings_components/current_med.dart';
import 'package:vitawatch/features/patient/screens/components/settings_components/settings.dart'
    as local_settings;
import 'package:vitawatch/features/patient/screens/components/settings_components/medical_info.dart';
import 'package:vitawatch/features/patient/screens/components/settings_components/medical_conditions.dart';
import 'package:vitawatch/features/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vitawatch/features/patient/screens/components/bottom_navigation_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Map<String, dynamic>? profileData;
  bool _isLoading = true;
  String?
  selectedAvatarUrl; // This will hold the avatar URL fetched from Firestore
  int _currentIndex = 3; // Set the initial index to the Profile tab

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  Future<void> _fetchProfileData() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('patient').doc(user.uid).get();

        if (userDoc.exists) {
          setState(() {
            profileData = userDoc.data() as Map<String, dynamic>;
            selectedAvatarUrl =
                profileData!['profileImage']; // Load avatar URL from Firestore
            _isLoading = false;
          });
        } else {
          debugPrint('User document not found');
          setState(() => _isLoading = false);
        }
      }
    } catch (e) {
      debugPrint('Error fetching profile data: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
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

            //container for the profile image
            SizedBox(
              width: screenWidth,
              height: screenHeight,

              child:
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : profileData == null
                      ? const Center(child: Text('No profile data found.'))
                      : Column(
                        children: [
                          // App Bar with Gradient Background
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 16.0,
                            ),
                            child: Row(
                              children: [
                                const Text(
                                  ' Profile',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontFamily: 'ClashDisplay',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Profile Information Section
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      // Display the profile avatar from Firestore
                                      selectedAvatarUrl != null
                                          ? CircleAvatar(
                                            radius: 40,
                                            backgroundImage: NetworkImage(
                                              selectedAvatarUrl ??
                                                  'https://i.imgur.com/G5PevHF.jpg', // Default avatar
                                            ),
                                          )
                                          : const CircleAvatar(
                                            radius: 40,
                                            backgroundColor: Color(0xFF2952D9),
                                            child: Icon(
                                              Icons.person,
                                              size: 40,
                                              color: Colors.white,
                                            ),
                                          ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              profileData!['firstname'] +
                                                      ' ' +
                                                      profileData!['lastname'] ??
                                                  'N/A',
                                              style: const TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'OpenSansJakarta',
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              profileData!['email'] ?? 'N/A',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Text(
                                              profileData!['role'] ?? 'N/A',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.green,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  const Divider(),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Phone: ${profileData!['phoneNumber'] ?? 'N/A'}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Address: ${profileData!['homeAdd'] ?? 'N/A'}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Menu Items Section
                          Expanded(
                            child: ListView(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              children: [
                                _buildMenuCard(
                                  icon: Icons.medical_information,
                                  label: 'Medical Information',
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) =>
                                                const MedicalInfoScreen(),
                                      ),
                                    );
                                  },
                                ),
                                _buildMenuCard(
                                  icon: Icons.health_and_safety,
                                  label: 'Medical Conditions',
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) =>
                                                const MedicalConditionsScreen(),
                                      ),
                                    );
                                  },
                                ),
                                _buildMenuCard(
                                  icon: Icons.settings,
                                  label: 'Settings',
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) =>
                                                const local_settings.Settings(),
                                      ),
                                    );
                                  },
                                ),
                                _buildMenuCard(
                                  icon: Icons.logout,
                                  label: 'Logout',
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Login(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }

  Widget _buildMenuCard({
    required IconData icon,
    required String label,
    VoidCallback? onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.indigo,
                child: Icon(icon, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.black54),
            ],
          ),
        ),
      ),
    );
  }
}
