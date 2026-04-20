import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:ntl_app/features/auth/signup/provider/signup_provider.dart';
import 'package:ntl_app/features/fetchService/app_logger.dart';
import 'package:ntl_app/features/profile/ui/pages/reusable_about_page.dart';
import 'package:ntl_app/core/layout/layout.dart';

class SupportPage extends ConsumerStatefulWidget {
  const SupportPage({super.key});

  @override
  ConsumerState<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends ConsumerState<SupportPage> {
  final name = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final message = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    email.dispose();
    message.dispose();
    super.dispose();
  }

  void _clearFields() {
    name.clear();
    phone.clear();
    email.clear();
    message.clear();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(supportProvider);

    ref.listen(supportProvider, (prev, next) {
      if (next.isSuccess) {
        AppSnackbar.show(
          context,
          "Request sent successfully",
          type: SnackType.success,
        );

        _clearFields();

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const MainScreen(initialIndex: 3)),
          (route) => false,
        );
      }

      if (next.error != null) {
        AppSnackbar.show(context, next.error!, type: SnackType.error);
      }
    });

    return ReusablePage(
      title: "About",
      heading: "Support",
      subHeading: RichText(
        text: const TextSpan(
          style: TextStyle(fontSize: 15, color: Colors.black87, height: 1.6),
          children: [
            TextSpan(text: "Get assistance with our services and support."),
          ],
        ),
      ),
      body: Skeletonizer(
        enabled: state.isLoading,
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            TextField(
              controller: name,
              enabled: !state.isLoading,
              decoration: const InputDecoration(hintText: "Enter your name"),
            ),
            const SizedBox(height: 14),

            TextField(
              controller: phone,
              enabled: !state.isLoading,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(hintText: "Phone Number"),
            ),
            const SizedBox(height: 14),

            TextField(
              controller: email,
              enabled: !state.isLoading,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(hintText: "Email"),
            ),
            const SizedBox(height: 14),

            TextField(
              controller: message,
              enabled: !state.isLoading,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: "Describe your issue",
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: state.isLoading
                    ? null
                    : () {
                        ref
                            .read(supportProvider.notifier)
                            .submitSupport(
                              name: name.text.trim(),
                              phone: phone.text.trim(),
                              email: email.text.trim(),
                              message: message.text.trim(),
                              service: "General Support",
                            );
                      },
                child: state.isLoading
                    ? const Text(
                        "Sending...",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      )
                    : const Text("Send Request"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
