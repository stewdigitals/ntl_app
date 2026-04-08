import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ntl_app/core/components/button.dart';
import 'package:ntl_app/features/auth/login/ui/login_page.dart';
import 'package:ntl_app/features/auth/otp-verification.dart/ui/otp_page.dart';
import 'package:ntl_app/features/auth/signup/state/auth_notifier.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  Future<void> _handleRegister() async {
    final name = nameController.text.trim();
    final phone = phoneController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirm = confirmPasswordController.text.trim();

    if (name.isEmpty ||
        phone.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirm.isEmpty) {
      showSnack("All fields are required");
      return;
    }

    if (password != confirm) {
      showSnack("Passwords do not match");
      return;
    }

    if (phone.length != 10) {
      showSnack("Invalid phone number");
      return;
    }

    await ref
        .read(authNotifierProvider.notifier)
        .register(email: email, password: password, name: name, phone: phone);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authNotifierProvider);

    ref.listen(authNotifierProvider, (previous, next) {
      if (next.error != null) {
        showSnack(next.error!);
      }

      if (!next.isLoading && next.data != null) {
        showSnack("Registration Successful 🎉");

        if (next.action == "register") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  OTPPage(email: emailController.text.trim(), flow: "signup"),
            ),
          );
        }
      }
    });
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F6),

      // 👇 THIS handles keyboard pushing content up
      resizeToAvoidBottomInset: true,

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Center(
              child: Image.asset("assets/horizontal_logo.png", height: 50),
            ),

            const SizedBox(height: 15),

            /// 🖼 Banner Image
            Stack(
              children: [
                Image.asset(
                  "assets/lab.png",
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
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

            const SizedBox(height: 10),

            /// 🧾 FIXED TITLE (not scrollable anymore)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Join Nagesh Touch Lab",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Register to access precision diagnostic\nreports and premium healthcare services.",
                    style: TextStyle(color: Color(0xFF64748B), height: 1.5),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            /// 🧾 SCROLLABLE FORM ONLY
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 10,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _label("Full Name"),
                    _inputField(
                      "Enter your legal name",
                      controller: nameController,
                    ),

                    const SizedBox(height: 14),

                    _label("Mobile Number"),
                    _inputField(
                      "9876543210",
                      controller: phoneController,
                      prefix: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text("+91"),
                            SizedBox(width: 8),
                            VerticalDivider(width: 1, thickness: 1),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    _label("Email Address"),
                    _inputField(
                      "example@email.com",
                      controller: emailController,
                    ),

                    const SizedBox(height: 14),

                    _label("Password"),
                    _inputField(
                      "Enter your password",
                      controller: passwordController,
                      isPassword: true,
                      obscureText: _obscurePassword,
                      onToggle: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),

                    const SizedBox(height: 14),

                    _label("Confirm Password"),
                    _inputField(
                      "Enter your password",
                      controller: confirmPasswordController,
                      isPassword: true,
                      obscureText: _obscureConfirmPassword,
                      onToggle: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                      errorText: confirmPasswordController.text.isEmpty
                          ? null
                          : (confirmPasswordController.text !=
                                    passwordController.text
                                ? "Passwords do not match"
                                : null),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            /// 🔴 FIXED BOTTOM SECTION
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(color: Color(0xFFF8F6F6)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomElevatedButton(
                    text: state.isLoading ? "Please wait..." : "Register Now",
                    onPressed: state.isLoading
                        ? null
                        : () async {
                            await _handleRegister();
                          },
                  ),

                  const SizedBox(height: 10),

                  Row(
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
                            color: Colors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
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

  void showSnack(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  /// 🔹 Input Field Widget
  Widget _inputField(
    String hint, {
    Widget? prefix,
    TextEditingController? controller,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onToggle,
    String? errorText,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? obscureText : false,

      onChanged: (_) {
        setState(() {}); // 👈 updates match validation live
      },

      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF94A3B8)),

        prefixIcon: prefix,

        // 👁 Eye button
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: onToggle,
              )
            : null,

        errorText: errorText,

        filled: true,
        fillColor: Colors.white,

        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 14,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE31C23), width: 1.2),
        ),
      ),
    );
  }
}
