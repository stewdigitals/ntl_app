// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ntl_app/core/layout/appbar.dart';
import 'package:ntl_app/core/layout/bottomnav.dart';
import 'package:ntl_app/features/appointments/ui/appointment_page.dart';
import 'package:ntl_app/features/auth/login/ui/login_page.dart';
import 'package:ntl_app/features/auth/signup/state/auth_notifier.dart';
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

class AuthGate extends ConsumerStatefulWidget {
  const AuthGate({super.key});

  @override
  ConsumerState<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends ConsumerState<AuthGate> {
  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  Future<void> checkAuth() async {
    final loggedIn = await ref.read(authNotifierProvider.notifier).isLoggedIn();

    if (loggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 🔵 Animated Loader
              SizedBox(height: 60, width: 60, child: PremiumLoader()),

              const SizedBox(height: 24),

              // 🧠 Brand Text
              Text(
                "Please wait...",
                style: GoogleFonts.spaceGrotesk(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "Checking authentication",
                style: GoogleFonts.spaceGrotesk(
                  color: Colors.white70,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PremiumLoader extends StatefulWidget {
  const PremiumLoader({super.key});

  @override
  State<PremiumLoader> createState() => _PremiumLoaderState();
}

class _PremiumLoaderState extends State<PremiumLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween(begin: 0.8, end: 1.2).animate(controller),
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFD4AF35),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
