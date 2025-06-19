// lib/main.dart
import 'package:flutter/material.dart';
import 'package:multi_page_app/pages/auth/login_page.dart';
import 'package:multi_page_app/pages/main_wrapper.dart'; // Import MainWrapper
import 'package:multi_page_app/services/auth_service.dart';
import 'package:multi_page_app/utils/app_colors.dart';
import 'package:multi_page_app/utils/app_styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService _authService = AuthService();
  bool _isLoggedIn = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    bool loggedIn = await _authService.isLoggedIn();
    setState(() {
      _isLoggedIn = loggedIn;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi-Page App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: AppColors.backgroundColor,
        appBarTheme: AppBarTheme(
          color: AppColors.primaryColor,
          titleTextStyle: AppStyles.headline2.copyWith(color: AppColors.white),
          iconTheme: const IconThemeData(color: AppColors.white),
        ),
        textTheme: TextTheme(
          displayLarge: AppStyles.headline1,
          displayMedium: AppStyles.headline2,
          titleLarge: AppStyles.subtitle1,
          bodyLarge: AppStyles.bodyText1,
          bodyMedium: AppStyles.bodyText2,
          labelLarge: AppStyles.buttonTextStyle,
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: AppColors.primaryColor,
          textTheme: ButtonTextTheme.primary,
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple)
            .copyWith(secondary: AppColors.accentColor),
      ),
      home: _isLoading
          ? const SplashScreen()
          : (_isLoggedIn ? const MainWrapper() : const LoginPage()), // Arahkan ke MainWrapper
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: AppColors.white),
            SizedBox(height: 20),
            Text(
              'Loading...',
              style: TextStyle(color: AppColors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}