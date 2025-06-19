// lib/pages/profile/profile_page.dart
import 'package:flutter/material.dart';
import 'package:multi_page_app/services/auth_service.dart';
import 'package:multi_page_app/utils/app_colors.dart';
import 'package:multi_page_app/utils/app_styles.dart';
import 'package:multi_page_app/widgets/custom_button.dart';
import 'package:multi_page_app/pages/profile/edit_profile_page.dart'; // Import halaman edit profil
import 'package:multi_page_app/pages/profile/change_password_page.dart'; // Import halaman ganti password

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _authService = AuthService();
  String _username = 'Loading...';
  String _email = 'Loading...';

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  // Metode untuk memuat data profil
  Future<void> _loadUserProfile() async {
    String? currentUsername = await _authService.getCurrentUsername();
    Map<String, dynamic>? user = await _authService.getCurrentUser();

    if (currentUsername != null) {
      setState(() {
        _username = currentUsername;
        _email = user?['email'] ?? 'N/A';
      });
    } else {
      setState(() {
        _username = 'Guest';
        _email = 'Not Logged In';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text('Profile', style: AppStyles.headline2.copyWith(color: AppColors.white)),
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundColor: AppColors.accentColor,
                child: Icon(Icons.person, size: 80, color: AppColors.white),
              ),
              const SizedBox(height: 30),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.account_circle, color: AppColors.primaryColor),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Username', style: AppStyles.bodyText2.copyWith(color: AppColors.textColor.withOpacity(0.7))),
                                Text(_username, style: AppStyles.subtitle1),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 30, color: AppColors.backgroundColor),
                      Row(
                        children: [
                          const Icon(Icons.email, color: AppColors.primaryColor),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Email', style: AppStyles.bodyText2.copyWith(color: AppColors.textColor.withOpacity(0.7))),
                                Text(_email, style: AppStyles.subtitle1),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              CustomButton(
                text: 'Edit Profile',
                onPressed: () async {
                  final bool? result = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const EditProfilePage()),
                  );
                  if (result == true) {
                    _loadUserProfile();
                  }
                },
                backgroundColor: AppColors.accentColor,
                textColor: AppColors.white,
              ),
              const SizedBox(height: 15),
              CustomButton(
                text: 'Change Password',
                onPressed: () async {
                  // Navigasi ke halaman ChangePasswordPage dan tunggu hasilnya
                  final bool? result = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const ChangePasswordPage()),
                  );
                  // Jika kembali dengan hasil 'true', Anda bisa memberikan feedback ke pengguna
                  if (result == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Password changed successfully!')),
                    );
                  }
                },
                backgroundColor: Colors.grey, // Warna berbeda untuk tombol sekunder
                textColor: AppColors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}