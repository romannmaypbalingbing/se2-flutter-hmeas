import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vitawatch/features/patient/screens/profile_screen.dart';
import 'package:vitawatch/features/patient/screens/components/settings_components/settings_subfolder/profileEdit.dart';
import 'package:vitawatch/features/patient/screens/components/settings_components/settings_subfolder/remindersAlert.dart';
import 'package:vitawatch/features/patient/screens/components/settings_components/settings_subfolder/changePassword.dart';
// import 'package:vitawatch/features/patient/screens/components/settings_components/settings_subfolder/language.dart';
import 'package:vitawatch/features/patient/screens/components/settings_components/settings_subfolder/helpSupport.dart';
import 'package:vitawatch/features/patient/screens/components/settings_components/settings_subfolder/privacyPolicy.dart';

Widget buildSettingsTile({
  required IconData icon,
  required String title,
  String? subtitle,
  required VoidCallback onTap,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    child: Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Icon(icon, color: Colors.black),
        title: Text(
          title,
          style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 16),
        ),
        subtitle: subtitle != null ? Text(subtitle) : null,
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    ),
  );
}

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Map<String, dynamic>? profileData;
  bool _isLoading = true;

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
            _isLoading = false;
          });
        } else {
          print('User document not found');
          setState(() => _isLoading = false);
        }
      }
    } catch (e) {
      print('Error fetching profile data: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          },
        ),
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                children: [
                  const SizedBox(height: 10),

                  // Profile Section
                  const ListTile(
                    title: Text(
                      'Profile Settings',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PlusJakartaSans',
                      ),
                    ),
                  ),
                  buildSettingsTile(
                    icon: Icons.person,
                    title: 'Edit Profile',
                    subtitle: 'Name: ${profileData?['name'] ?? 'N/A'}',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => EditProfileScreen()),
                      );
                    },
                  ),
                  // Notifications
                  const ListTile(
                    title: Text(
                      'Notifications',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  buildSettingsTile(
                    icon: Icons.notifications,
                    title: 'Reminders & Alerts',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RemindersAndAlertsScreen(),
                        ),
                      );
                    },
                  ),

                  // Data & Security
                  const ListTile(
                    title: Text(
                      'Privacy & Security',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  buildSettingsTile(
                    icon: Icons.lock,
                    title: 'Change Password',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChangePasswordScreen(),
                        ),
                      );
                    },
                  ),

                  // Language & Accessibility
                  const ListTile(
                    title: Text(
                      'General',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  // Support & Legal
                  const ListTile(
                    title: Text(
                      'Support',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  buildSettingsTile(
                    icon: Icons.help_outline,
                    title: 'Help & Support',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HelpAndSupportScreen(),
                        ),
                      );
                    },
                  ),
                  buildSettingsTile(
                    icon: Icons.policy,
                    title: 'Privacy Policy',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PrivacyPolicyScreen(),
                        ),
                      );
                    },
                  ),
                  buildSettingsTile(
                    icon: Icons.info,
                    title: 'App Version',
                    subtitle: 'v1.0.0',
                    onTap: () {},
                  ),
                ],
              ),
    );
  }
}
