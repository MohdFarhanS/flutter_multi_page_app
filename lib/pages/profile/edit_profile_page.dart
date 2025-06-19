// lib/pages/profile/edit_profile_page.dart
import 'package:flutter/material.dart';
import 'package:multi_page_app/services/auth_service.dart';
import 'package:multi_page_app/utils/app_colors.dart';
import 'package:multi_page_app/utils/app_styles.dart';
import 'package:multi_page_app/widgets/custom_button.dart';
import 'package:multi_page_app/widgets/custom_text_field.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final AuthService _authService = AuthService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadCurrentUserData();
  }

  Future<void> _loadCurrentUserData() async {
    setState(() {
      _isLoading = true;
    });
    Map<String, dynamic>? currentUser = await _authService.getCurrentUser();
    String? currentUsername = await _authService.getCurrentUsername();

    if (currentUser != null && currentUsername != null) {
      _usernameController.text = currentUsername; // Username diambil dari SharedPreferences
      _emailController.text = currentUser['email'] ?? '';
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _updateProfile() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final String newUsername = _usernameController.text.trim();
    final String newEmail = _emailController.text.trim();

    if (newUsername.isEmpty || newEmail.isEmpty) {
      setState(() {
        _errorMessage = 'Username and Email cannot be empty.';
        _isLoading = false;
      });
      return;
    }

    // Panggil service untuk update profil (metode ini perlu ditambahkan di AuthService)
    bool success = await _authService.updateUserProfile(newUsername, newEmail);

    setState(() {
      _isLoading = false;
    });

    if (success) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully!'),
          backgroundColor: AppColors.success,
        ),
      );
      // Kembali ke halaman profil setelah berhasil update
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop(true); // Kirim true untuk menandakan update berhasil
    } else {
      setState(() {
        _errorMessage = 'Failed to update profile. Please try again.';
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text('Edit Profile', style: AppStyles.headline2.copyWith(color: AppColors.white)),
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Update Your Information',
                    style: AppStyles.headline1.copyWith(color: AppColors.primaryColor),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  CustomTextField(
                    controller: _usernameController,
                    labelText: 'Username',
                    prefixIcon: const Icon(Icons.person, color: AppColors.primaryColor),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: _emailController,
                    labelText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(Icons.email, color: AppColors.primaryColor),
                  ),
                  const SizedBox(height: 30),
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Text(
                        _errorMessage!,
                        style: AppStyles.bodyText2.copyWith(color: AppColors.error),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  CustomButton(
                    text: 'Save Changes',
                    onPressed: _updateProfile,
                    backgroundColor: AppColors.accentColor,
                  ),
                ],
              ),
            ),
    );
  }
}