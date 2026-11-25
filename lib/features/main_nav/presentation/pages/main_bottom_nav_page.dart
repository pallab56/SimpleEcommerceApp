import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// Placeholder MainBottomNavPage — will be fully implemented
/// when the Home, Categories, Cart, and Wishlist features are built.
class MainBottomNavPage extends StatefulWidget {
  const MainBottomNavPage({super.key});

  @override
  State<MainBottomNavPage> createState() => _MainBottomNavPageState();
}

class _MainBottomNavPageState extends State<MainBottomNavPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    Center(child: Text('Home')),
    Center(child: Text('Categories')),
    Center(child: Text('Cart')),
    Center(child: Text('Wishlist')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view_outlined), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Wishlist'),
        ],
      ),
    );
  }
}
