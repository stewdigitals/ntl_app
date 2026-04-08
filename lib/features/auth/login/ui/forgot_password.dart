// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ntl_app/core/components/button.dart';
import 'package:ntl_app/features/auth/login/ui/login_page.dart';
import 'package:ntl_app/features/auth/signup/state/auth_notifier.dart';
import 'package:ntl_app/features/auth/signup/ui/signup_page.dart';

class ResetPasswordPage extends ConsumerStatefulWidget {
  final String email;

  const ResetPasswordPage({super.key, required this.email});

  @override
  ConsumerState<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends ConsumerState<ResetPasswordPage> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  void showSnack(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authNotifierProvider);

    ref.listen(authNotifierProvider, (previous, next) {
      if (next.error != null) {
        showSnack(next.error!);
      }

      if (!next.isLoading && next.data != null) {
        if (next.action == "forgotPassword") {
          showSnack("OTP Sent 📩");
        }

        if (next.action == "resetPassword") {
          showSnack("Password Changed Successfully 🎉");

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => LoginPage()),
          ); // or go to login
        }

        ref.read(authNotifierProvider.notifier).clearState();
      }
    });
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

              Column(
                children: [
                  Text(
                    "Changing password for",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.text,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    widget.email,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              /// 🔐 New Password
              TextField(
                controller: passwordController,
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

              const SizedBox(height: 16),

              /// 🔐 Confirm Password
              TextField(
                controller: confirmPasswordController,
                obscureText: !isConfirmPasswordVisible,
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
                      isConfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        isConfirmPasswordVisible = !isConfirmPasswordVisible;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 25),

              /// 🔴 Reset Button
              CustomElevatedButton(
                text: state.isLoading ? "Processing..." : "Reset Password",
                onPressed: state.isLoading
                    ? null
                    : () async {
                        final password = passwordController.text.trim();
                        final confirmPassword = confirmPasswordController.text
                            .trim();

                        if (password.isEmpty || confirmPassword.isEmpty) {
                          showSnack("All fields required");
                          return;
                        }

                        if (password != confirmPassword) {
                          showSnack("Passwords do not match");
                          return;
                        }

                        await ref
                            .read(authNotifierProvider.notifier)
                            .resetPassword(
                              email: widget.email,
                              newPassword: password,
                              context: context,
                            );
                      },
              ),

              const SizedBox(height: 14),

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
