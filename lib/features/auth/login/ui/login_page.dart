// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ntl_app/core/components/button.dart';
import 'package:ntl_app/features/auth/signup/ui/signup_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),

              /// 🔴 Logo + Title
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/horizontal_logo.png", height: 50),
                ],
              ),

              const SizedBox(height: 20),

              /// 🖼 Gold Image Card
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  "assets/login.png",
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width * 0.85,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                "Welcome Back",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  color: Colors.heading,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Login to your customer account to access\ntouch testing reports",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.text,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 20),

              /// 📱 Input Label
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.heading,
                    fontSize: 15,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              /// 🧾 Input Field
              TextField(
                decoration: InputDecoration(
                  hintText: "e.g. name@mail.com",
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    color: Colors.icon,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),

                  /// 👇 Default border
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFFE2E8F0),
                      width: 1, // ❗ increase this
                    ),
                  ),

                  /// 👇 When not focused
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFFE2E8F0),
                      width: 1,
                    ),
                  ),

                  /// 👇 When focused
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.red, // 👈 your primary color
                      width: 1.5,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 15),

              /// 🔐 Password Label
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Password",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.heading,
                    fontSize: 15,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              /// 🔐 Password Field
              TextField(
                obscureText: !isPasswordVisible,
                decoration: InputDecoration(
                  hintText: "Enter your password",
                  prefixIcon: const Icon(Icons.lock_outline),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  filled: true,
                  fillColor: Colors.white,

                  /// 👇 Default border
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFFE2E8F0),
                      width: 1, // ❗ increase this
                    ),
                  ),

                  /// 👇 When not focused
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFFE2E8F0),
                      width: 1,
                    ),
                  ),

                  /// 👇 When focused
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.red, // 👈 your primary color
                      width: 1.5,
                    ),
                  ),

                  /// 👁️ Eye Toggle Button
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// 🔴 Login Button
              CustomElevatedButton(text: "Login", onPressed: () {}),

              const SizedBox(height: 14),

              /// 🟡 Register
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    ),
                  );
                },
                child: const Text(
                  "Register as New Customer",
                  style: TextStyle(
                    color: Colors.accent,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              /// ➖ Divider with HELP
              Row(
                children: const [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text("HELP", style: TextStyle(color: Colors.text)),
                  ),
                  Expanded(child: Divider()),
                ],
              ),

              const SizedBox(height: 10),

              /// 📞 Help Text
              InkWell(
                onTap: () {},
                child: const Text(
                  "Need help logging in? Contact Support",
                  style: TextStyle(color: Colors.text),
                ),
              ),

              const SizedBox(height: 20),

              /// 🟣 Bottom Indicator
              Container(
                height: 4,
                width: 60,
                decoration: BoxDecoration(
                  color: Color(0xFFE31C23).withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
