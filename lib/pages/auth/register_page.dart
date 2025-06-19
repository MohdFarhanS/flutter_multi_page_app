// lib/pages/auth/register_page.dart
import 'package:flutter/material.dart';
// import 'package:multi_page_app/pages/home/home_page.dart'; // Setelah register, mungkin langsung ke home
import 'package:multi_page_app/pages/main_wrapper.dart';
import 'package:multi_page_app/services/auth_service.dart'; // Akan diperluas untuk register
import 'package:multi_page_app/utils/app_colors.dart';
import 'package:multi_page_app/utils/app_styles.dart';
import 'package:multi_page_app/widgets/custom_button.dart';
import 'package:multi_page_app/widgets/custom_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController(); // Tambahan untuk email
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController(); // Tambahan untuk konfirmasi password

  final AuthService _authService = AuthService(); // Akan diperluas
  bool _isLoading = false;
  String? _errorMessage;

  void _register() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final String username = _usernameController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final String confirmPassword = _confirmPasswordController.text;

    if (password != confirmPassword) {
      setState(() {
        _errorMessage = 'Passwords do not match.';
        _isLoading = false;
      });
      return;
    }

    // TODO: Implement actual registration logic with backend/Auth Service
    // For now, simulate success
    bool success = await _authService.register(username, email, password); // Anda perlu menambahkan metode register ke AuthService

    setState(() {
      _isLoading = false;
    });

    if (success) {
      // Mungkin langsung login setelah register, atau verifikasi email
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration successful for $username!'),
          backgroundColor: AppColors.success,
        ),
      );
      Navigator.of(context).pushAndRemoveUntil(
  MaterialPageRoute(builder: (context) => const MainWrapper()), // Arahkan ke MainWrapper
  (Route<dynamic> route) => false, // Hapus semua rute sebelumnya
);
    } else {
      setState(() {
        _errorMessage = 'Registration failed. Please try again.'; // Atau pesan error spesifik dari backend
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text('Create Account', style: AppStyles.headline2.copyWith(color: AppColors.white)),
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
                'Join Us!',
                style: AppStyles.headline1.copyWith(color: AppColors.primaryColor),
              ),
              const SizedBox(height: 10),
              Text(
                'Create your account to get started.',
                style: AppStyles.bodyText1.copyWith(color: AppColors.textColor.withOpacity(0.7)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
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
              const SizedBox(height: 20),
              CustomTextField(
                controller: _passwordController,
                labelText: 'Password',
                obscureText: true,
                prefixIcon: const Icon(Icons.lock, color: AppColors.primaryColor),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _confirmPasswordController,
                labelText: 'Confirm Password',
                obscureText: true,
                prefixIcon: const Icon(Icons.lock_reset, color: AppColors.primaryColor),
              ),
              const SizedBox(height: 20),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Text(
                    _errorMessage!,
                    style: AppStyles.bodyText2.copyWith(color: AppColors.error),
                  ),
                ),
              _isLoading
                  ? const CircularProgressIndicator(color: AppColors.primaryColor)
                  : CustomButton(
                      text: 'Register',
                      onPressed: _register,
                    ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Kembali ke halaman login
                },
                child: Text(
                  'Already have an account? Sign In',
                  style: AppStyles.bodyText2.copyWith(color: AppColors.primaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}