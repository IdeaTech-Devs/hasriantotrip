import 'package:flutter/material.dart';
import 'homescreen.dart';
import 'historyscreen.dart';
import 'profilescreen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class NavbarScreen extends StatefulWidget {
  @override
  _NavbarScreenState createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  int _currentIndex = 1; // Indeks untuk halaman Home
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
        children: [
          HistoryScreen(), // History di posisi kedua
          HomeScreen(), // Home di posisi pertama
          ProfileScreen(), // Profile di posisi ketiga
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        height: 60, // Tinggi ideal untuk navbar
        items: const <Widget>[
          Icon(Icons.history,
              size: 30, color: Colors.white), // Ikon sejarah berwarna putih
          Icon(Icons.home,
              size: 30, color: Colors.white), // Ikon rumah berwarna putih
          Icon(Icons.person,
              size: 30, color: Colors.white), // Ikon profil berwarna putih
        ],
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        backgroundColor: Colors.white,
        color: Colors.blue.shade100, // Warna latar belakang yang lebih lembut
        buttonBackgroundColor: Colors.blue, // Warna tombol yang lebih menonjol
        animationDuration:
            const Duration(milliseconds: 200), // Animasi yang lebih cepat
        animationCurve: Curves.easeInOut, // Kurva animasi yang lebih halus
      ),
    );
  }
}
