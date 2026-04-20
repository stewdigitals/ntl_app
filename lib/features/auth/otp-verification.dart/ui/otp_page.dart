// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ntl_app/core/components/button.dart';
import 'package:ntl_app/features/auth/login/ui/forgot_password.dart';
import 'package:ntl_app/features/auth/login/ui/login_page.dart';
import 'package:ntl_app/features/auth/signup/state/auth_notifier.dart';
import 'package:ntl_app/features/auth/signup/ui/signup_page.dart';
import 'package:ntl_app/features/fetchService/app_logger.dart';

class OTPPage extends ConsumerStatefulWidget {
  final String email;
  final String flow;

  const OTPPage({super.key, required this.email, required this.flow});

  @override
  ConsumerState<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends ConsumerState<OTPPage> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  bool isPasswordVisible = false;

  void showSnack(String message) {
    AppSnackbar.show(context, message);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authNotifierProvider, (previous, next) {
      if (next.error != null) {
        showSnack(next.error!);
      }

      if (!next.isLoading && next.data != null) {
        if (next.action == "verifyOtp") {
          showSnack("OTP Verified 🎉");

          if (widget.flow == "forgotPassword") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => ResetPasswordPage(email: widget.email),
              ),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginPage()),
            );
          }
        }

        if (next.action == "resendOtp") {
          showSnack("OTP Sent Again 📩");
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
                  "Enter OTP",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.heading,
                    fontSize: 15,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return Container(
                    width: 48,
                    height: 58,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        counterText: "",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFE2E8F0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 1.5,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          if (index < 5) {
                            FocusScope.of(
                              context,
                            ).requestFocus(_focusNodes[index + 1]);
                          }
                        } else {
                          if (index > 0) {
                            FocusScope.of(
                              context,
                            ).requestFocus(_focusNodes[index - 1]);
                          }
                        }
                      },
                    ),
                  );
                }),
              ),

              TextButton(
                onPressed: () {
                  ref
                      .read(authNotifierProvider.notifier)
                      .resendOtp(email: widget.email, context: context);
                },
                child: const Text(
                  "Resend OTP",
                  style: TextStyle(
                    color: Colors.primary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),

              /// 🔴 Login Button
              CustomElevatedButton(
                text: "Verify OTP",
                onPressed: () async {
                  String otp = _controllers.map((e) => e.text).join();

                  if (otp.length < 4) {
                    showSnack("Enter complete OTP");
                    return;
                  }

                  await ref
                      .read(authNotifierProvider.notifier)
                      .verifyOtp(
                        email: widget.email,
                        otp: otp,
                        context: context,
                      );
                },
              ),

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
