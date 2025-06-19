// lib/pages/auth/forgot_password_page.dart
import 'package:flutter/material.dart';
import 'package:multi_page_app/services/auth_service.dart';
import 'package:multi_page_app/utils/app_colors.dart';
import 'package:multi_page_app/utils/app_styles.dart';
import 'package:multi_page_app/widgets/custom_button.dart';
import 'package:multi_page_app/widgets/custom_text_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _usernameController = TextEditingController(); // Ubah ke username
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  String? _message;
  bool _isSuccess = false;

  void _resetPassword() async {
    setState(() {
      _isLoading = true;
      _message = null;
      _isSuccess = false;
    });

    final String usernameInput = _usernameController.text.trim(); // Ambil input username

    if (usernameInput.isEmpty) {
      setState(() {
        _message = 'Please enter your username.';
        _isLoading = false;
      });
      return;
    }

    // Panggil service baru untuk reset password ke default
    bool success = await _authService.resetPasswordWithDefault(usernameInput);

    setState(() {
      _isLoading = false;
    });

    if (success) {
      setState(() {
        _message = 'Password for "$usernameInput" has been reset to "123456". Please login with the new password.';
        _isSuccess = true;
      });
      // Berikan sedikit waktu agar pesan terbaca, lalu kembali ke login
      Future.delayed(const Duration(seconds: 4), () {
        if (mounted) {
          Navigator.of(context).pop();
        }
      });
    } else {
      setState(() {
        _message = 'Username "$usernameInput" not found. Please try again.';
        _isSuccess = false;
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text('Reset Password', style: AppStyles.headline2.copyWith(color: AppColors.white)), // Ubah judul
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
                'Reset Your Password',
                style: AppStyles.headline1.copyWith(color: AppColors.primaryColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Enter your username. Your password will be reset to a default value.', // Ubah deskripsi
                style: AppStyles.bodyText1.copyWith(color: AppColors.textColor.withOpacity(0.7)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              CustomTextField(
                controller: _usernameController, // Gunakan controller username
                labelText: 'Username', // Ubah label
                keyboardType: TextInputType.text, // Pastikan keyboardType sesuai
                prefixIcon: const Icon(Icons.person, color: AppColors.primaryColor), // Ubah icon
              ),
              const SizedBox(height: 20),
              if (_message != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Text(
                    _message!,
                    style: AppStyles.bodyText2.copyWith(
                      color: _isSuccess ? AppColors.success : AppColors.error,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              _isLoading
                  ? const CircularProgressIndicator(color: AppColors.primaryColor)
                  : CustomButton(
                      text: 'Reset Password',
                      onPressed: _resetPassword,
                      backgroundColor: AppColors.accentColor,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}