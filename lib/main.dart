// ============================================================
// TEN11 Women Fashion App - Complete E-Commerce Application
// ============================================================
// File: lib/main.dart
// Project layout:
//   lib/main.dart                 <- app entry point, theme, routes
//   lib/models/                   <- one data class per file
//   lib/data/product_data.dart    <- static product catalogue
//   lib/widgets/                  <- shared reusable widgets
//   lib/screens/                  <- one screen per file
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/splash_screen.dart';
import 'screens/home_page.dart';
import 'screens/product_detail_page.dart';
import 'screens/cart_page.dart';
import 'screens/wishlist_page.dart';
import 'screens/profile_page.dart';
import 'screens/search_page.dart';
import 'screens/category_page.dart';

void main() {
  runApp(const MyTen11App());
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
}

class MyTen11App extends StatelessWidget {
  const MyTen11App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TEN11',
      theme: _buildTheme(),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const WomenHomePage(),
        '/product': (context) => const ProductDetailPage(),
        '/cart': (context) => const CartPage(),
        '/wishlist': (context) => const WishlistPage(),
        '/profile': (context) => const ProfilePage(),
        '/search': (context) => const SearchPage(),
        '/category': (context) => const CategoryPage(),
      },
    );
  }

  ThemeData _buildTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFE91E63),
        primary: const Color(0xFFE91E63),
        secondary: const Color(0xFF9C27B0),
        surface: Colors.white,
        background: const Color(0xFFF5F5F5),
      ),
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFFE91E63),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE91E63)),
        ),
        hintStyle: TextStyle(color: Colors.grey.shade400),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE91E63),
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        displayMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        displaySmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
        bodyMedium: TextStyle(fontSize: 14, color: Colors.black87),
        bodySmall: TextStyle(fontSize: 12, color: Colors.grey),
        labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }
}
