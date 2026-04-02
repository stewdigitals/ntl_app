import 'package:flutter/material.dart';
import 'package:ntl_app/core/layout/appbar.dart';
import 'package:ntl_app/core/layout/bottomnav.dart';

class AppLayout extends StatelessWidget {
  final Widget child;
  final int currentIndex;
  final Function(int) onTabChange;
  final bool showAppBar;

  const AppLayout({
    super.key,
    required this.child,
    required this.currentIndex,
    required this.onTabChange,
    this.showAppBar = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: showAppBar ? 90 : 0, bottom: 60),
              child: child,
            ),

            if (showAppBar) const CustomAppBar(),

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
