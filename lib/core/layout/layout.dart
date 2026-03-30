import 'package:flutter/material.dart';
import 'package:ntl_app/core/layout/appbar.dart';
import 'package:ntl_app/core/layout/bottomnav.dart';

class AppLayout extends StatelessWidget {
  final Widget child;
  final int currentIndex;
  final Function(int) onTabChange;

  const AppLayout({
    super.key,
    required this.child,
    required this.currentIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        // 🔥 ensures full screen
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 90, bottom: 70),
              child: SingleChildScrollView(child: child),
            ),
            const CustomAppBar(),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CustomBottomNavBar(
                currentIndex: currentIndex,
                onTap: onTabChange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
