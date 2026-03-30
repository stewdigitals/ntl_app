import 'package:flutter/material.dart';
import 'package:ntl_app/core/components/button.dart';
import 'package:ntl_app/features/auth/login/ui/login_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F6),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔴 Top Logo
              const SizedBox(height: 10),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset("assets/horizontal_logo.png", height: 50),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              /// 🖼 Banner Image
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: Image.asset(
                      "assets/lab.png", // replace with your image
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    left: 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(height: 4, width: 30, color: Colors.amber),
                        const SizedBox(height: 6),
                        const Text(
                          "Premium Care",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// 📦 Content Padding
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 📝 Title
                    const Text(
                      "Join Nagesh Touch Lab",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "Register to access precision diagnostic\nreports and premium healthcare services.",
                      style: TextStyle(color: Color(0xFF64748B), height: 1.5),
                    ),

                    const SizedBox(height: 20),

                    /// 🧾 Full Name
                    _label("Full Name"),
                    _inputField("Enter your legal name"),

                    const SizedBox(height: 14),

                    /// 📱 Mobile
                    _label("Mobile Number *"),
                    _inputField(
                      "9876543210",
                      prefix: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text("+91", style: TextStyle(color: Colors.black)),
                            SizedBox(width: 8),
                            VerticalDivider(width: 1, thickness: 1),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    /// 📧 Email
                    _label("Email Address (Optional)"),
                    _inputField("example@email.com"),

                    const SizedBox(height: 14),

                    /// 🎟 Referral
                    _label("Referral Code"),
                    _inputField("Enter code for special offers"),

                    const SizedBox(height: 25),

                    /// 🔴 Button
                    CustomElevatedButton(
                      text: "Register Now",
                      onPressed: () {},
                    ),

                    const SizedBox(height: 14),

                    /// 🔁 Login Redirect
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account? ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 Label Widget
  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }

  /// 🔹 Input Field Widget
  Widget _inputField(String hint, {Widget? prefix}) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF94A3B8)),

        prefixIcon: prefix,

        filled: true,
        fillColor: Colors.white,

        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFFE2E8F0),
            width: 1, // ❗ increase this
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE31C23), width: 1.2),
        ),
      ),
    );
  }
}
