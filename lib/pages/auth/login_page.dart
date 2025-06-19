// lib/pages/auth/login_page.dart
import 'package:flutter/material.dart';
import 'package:multi_page_app/pages/auth/register_page.dart';
import 'package:multi_page_app/pages/auth/forgot_password_page.dart'; // Import halaman forgot password
import 'package:multi_page_app/pages/main_wrapper.dart'; // Perbaikan navigasi sebelumnya
import 'package:multi_page_app/services/auth_service.dart';
import 'package:multi_page_app/utils/app_colors.dart';
import 'package:multi_page_app/utils/app_styles.dart';
import 'package:multi_page_app/widgets/custom_button.dart';
import 'package:multi_page_app/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  String? _errorMessage;

  void _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final String username = _usernameController.text;
    final String password = _passwordController.text;

    bool success = await _authService.login(username, password);

    setState(() {
      _isLoading = false;
    });

    if (success) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil( // Perbaikan navigasi: Arahkan ke MainWrapper
        MaterialPageRoute(builder: (context) => const MainWrapper()),
        (Route<dynamic> route) => false,
      );
    } else {
      setState(() {
        _errorMessage = 'Invalid username or password.';
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome Back!',
                style: AppStyles.headline1.copyWith(color: AppColors.primaryColor),
              ),
              const SizedBox(height: 10),
              Text(
                'Sign in to continue to your account.',
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
                controller: _passwordController,
                labelText: 'Password',
                obscureText: true,
                prefixIcon: const Icon(Icons.lock, color: AppColors.primaryColor),
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
                      text: 'Login',
                      onPressed: _login,
                    ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  // Navigasi ke halaman forgot password
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const ForgotPasswordPage()),
                  );
                },
                child: Text(
                  'Forgot Password?',
                  style: AppStyles.bodyText2.copyWith(color: AppColors.primaryColor),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const RegisterPage()),
                  );
                },
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: AppStyles.bodyText2.copyWith(color: AppColors.textColor),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Register Now',
                        style: AppStyles.bodyText2.copyWith(
                          color: AppColors.accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}