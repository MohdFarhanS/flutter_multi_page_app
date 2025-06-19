// lib/pages/profile/change_password_page.dart
import 'package:flutter/material.dart';
import 'package:multi_page_app/services/auth_service.dart';
import 'package:multi_page_app/utils/app_colors.dart';
import 'package:multi_page_app/utils/app_styles.dart';
import 'package:multi_page_app/widgets/custom_button.dart';
import 'package:multi_page_app/widgets/custom_text_field.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final AuthService _authService = AuthService();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _changePassword() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final String oldPassword = _oldPasswordController.text;
    final String newPassword = _newPasswordController.text;
    final String confirmNewPassword = _confirmNewPasswordController.text;

    if (oldPassword.isEmpty || newPassword.isEmpty || confirmNewPassword.isEmpty) {
      setState(() {
        _errorMessage = 'All fields are required.';
        _isLoading = false;
      });
      return;
    }

    if (newPassword.length < 6) {
      setState(() {
        _errorMessage = 'New password must be at least 6 characters long.';
        _isLoading = false;
      });
      return;
    }

    if (newPassword != confirmNewPassword) {
      setState(() {
        _errorMessage = 'New passwords do not match.';
        _isLoading = false;
      });
      return;
    }

    // Panggil service untuk ganti password (metode ini perlu ditambahkan di AuthService)
    bool success = await _authService.changePassword(oldPassword, newPassword);

    setState(() {
      _isLoading = false;
    });

    if (success) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password changed successfully!'),
          backgroundColor: AppColors.success,
        ),
      );
      // Kembali ke halaman profil setelah berhasil update
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop(true); // Kirim true untuk menandakan update berhasil
    } else {
      setState(() {
        _errorMessage = 'Failed to change password. Please check your old password.';
      });
    }
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text('Change Password', style: AppStyles.headline2.copyWith(color: AppColors.white)),
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Update Your Password',
                style: AppStyles.headline1.copyWith(color: AppColors.primaryColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              CustomTextField(
                controller: _oldPasswordController,
                labelText: 'Old Password',
                obscureText: true,
                prefixIcon: const Icon(Icons.lock_outline, color: AppColors.primaryColor),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _newPasswordController,
                labelText: 'New Password',
                obscureText: true,
                prefixIcon: const Icon(Icons.lock, color: AppColors.primaryColor),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _confirmNewPasswordController,
                labelText: 'Confirm New Password',
                obscureText: true,
                prefixIcon: const Icon(Icons.lock_reset, color: AppColors.primaryColor),
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
              _isLoading
                  ? const CircularProgressIndicator(color: AppColors.primaryColor)
                  : CustomButton(
                      text: 'Change Password',
                      onPressed: _changePassword,
                      backgroundColor: AppColors.accentColor,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}