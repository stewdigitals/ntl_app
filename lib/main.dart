import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ntl_app/features/home/ui/home_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTheme = ThemeData();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: baseTheme.copyWith(
        scaffoldBackgroundColor: Colors.background,

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.primary,
            foregroundColor: Colors.white,
            textStyle: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w900),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),

            elevation: 0,
          ),
        ),

        /// 🌟 Apply font globally
        textTheme: GoogleFonts.spaceGroteskTextTheme(baseTheme.textTheme),
        primaryTextTheme: GoogleFonts.spaceGroteskTextTheme(
          baseTheme.primaryTextTheme,
        ),

        appBarTheme: baseTheme.appBarTheme.copyWith(
          backgroundColor: Colors.background,
          elevation: 0,
          titleTextStyle: GoogleFonts.spaceGrotesk(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xFFE2E8F0), width: 1),
          ),
          filled: true,
          fillColor: Colors.white,
        ),

        cardColor: Colors.background,
      ),
      home: HomePage(),
    );
  }
}

// Colors
//   static const Color primary = Color(0xFFE31C23);
//   static const Color secondary = Color(0xFF0F172A);
//   static const Color accent = Color(0xFFD4AF35);
//   static const Color background = Color(0xFFF8F6F6);
