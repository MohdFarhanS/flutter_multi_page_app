// lib/pages/main_wrapper.dart
import 'package:flutter/material.dart';
import 'package:multi_page_app/pages/home/home_page.dart';
import 'package:multi_page_app/pages/profile/profile_page.dart';
// import 'package:multi_page_app/services/auth_service.dart'; // Untuk logout
// import 'package:multi_page_app/pages/auth/login_page.dart'; // Untuk redirect setelah logout
import 'package:multi_page_app/utils/app_colors.dart'; // Untuk warna bottom nav

class MainWrapper extends StatefulWidget {
  const MainWrapper({Key? key}) : super(key: key);

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0; // Indeks halaman yang sedang aktif

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex), // Menampilkan halaman yang dipilih
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primaryColor, // Warna item yang dipilih
        unselectedItemColor: Colors.grey, // Warna item yang tidak dipilih
        onTap: _onItemTapped,
        backgroundColor: AppColors.white,
        elevation: 8,
        type: BottomNavigationBarType.fixed, // Memastikan label selalu terlihat
      ),
    );
  }
}