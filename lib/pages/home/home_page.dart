// lib/pages/home/home_page.dart
import 'package:flutter/material.dart';
import 'package:multi_page_app/models/item.dart';
import 'package:multi_page_app/pages/auth/login_page.dart';
// import 'package:flutter_multi_page_app/pages/auth/login_page.dart'; // Ini tidak lagi diperlukan karena logout di MainWrapper atau di ProfilePage
import 'package:multi_page_app/pages/detail/detail_page.dart';
import 'package:multi_page_app/services/auth_service.dart';
import 'package:multi_page_app/utils/app_colors.dart';
import 'package:multi_page_app/utils/app_styles.dart';
import 'package:multi_page_app/widgets/item_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _authService = AuthService(); // Masih perlu untuk logout jika di sini
  List<Item> items = [
    Item(
      id: 1,
      name: 'Modern Chair',
      description: 'A comfortable and stylish chair for your modern home decor.',
      imageUrl: 'assets/images/modern_chair.png',
      price: 120.00,
    ),
    Item(
      id: 2,
      name: 'Minimalist Lamp',
      description: 'Illuminate your space with this sleek and minimalist lamp.',
      imageUrl: 'assets/images/minimalist_lamP.png',
      price: 45.50,
    ),
    Item(
      id: 3,
      name: 'Ergonomic Desk',
      description: 'Boost your productivity with this adjustable ergonomic desk.',
      imageUrl: 'assets/images/ergonimic_desk.png',
      price: 299.99,
    ),
    Item(
      id: 4,
      name: 'Smart Speaker',
      description: 'Experience immersive sound with this smart voice-controlled speaker.',
      imageUrl: 'assets/images/smart_speaker.jpeg',
      price: 99.00,
    ),
  ];

  void _logout() async {
    await _authService.logout();
    // Karena ini di dalam MainWrapper, kita perlu pop semua route dan push LoginPage
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (Route<dynamic> route) => false, // Menghapus semua route sebelumnya
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar( // AppBar tetap ada untuk judul dan tombol logout
        title: Text('Home', style: AppStyles.headline2.copyWith(color: AppColors.white)),
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.white),
            onPressed: _logout,
            tooltip: 'Logout',
          ),
        ],
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ItemCard(
            item: item,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailPage(item: item),
                ),
              );
            },
          );
        },
      ),
    );
  }
}