// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ntl_app/core/layout/appbar.dart';
import 'package:ntl_app/core/layout/bottomnav.dart';
import 'package:ntl_app/features/appointments/ui/appointment_page.dart';
import 'package:ntl_app/features/auth/login/ui/login_page.dart';
import 'package:ntl_app/features/home/ui/home_page.dart';
import 'package:ntl_app/features/profile/ui/profile_page.dart';
import 'package:ntl_app/features/service/ui/service_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLayout extends StatelessWidget {
  final Widget child;
  final bool showAppBar;

  const AppLayout({super.key, required this.child, this.showAppBar = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          if (showAppBar) const CustomAppBar(),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  final int initialIndex;

  const MainScreen({super.key, this.initialIndex = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int currentIndex;
  bool isCheckingAuth = true;

  @override
  void initState() {
    super.initState();

    currentIndex = widget.initialIndex;
    checkAuth();
  }

  Future<void> checkAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null || token.isEmpty) {
      redirectToLogin();
      return;
    }

    if (isTokenExpired(token)) {
      await prefs.remove('auth_token');
      redirectToLogin();
      return;
    }

    setState(() {
      isCheckingAuth = false;
    });
  }

  bool isTokenExpired(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return true;

      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      final decoded = String.fromCharCodes(base64Url.decode(normalized));

      final exp = RegExp(r'"exp":\s*(\d+)').firstMatch(decoded);
      if (exp == null) return false;

      final expiry = DateTime.fromMillisecondsSinceEpoch(
        int.parse(exp.group(1)!) * 1000,
      );

      return DateTime.now().isAfter(expiry);
    } catch (e) {
      return true;
    }
  }

  void redirectToLogin() {
    Future.microtask(() {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isCheckingAuth) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final pages = [
      const HomePage(),
      const ServicePage(),
      const MyAppointmentsPage(),
      const ProfilePage(),
    ];

    return Scaffold(
      body: IndexedStack(index: currentIndex, children: pages),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
