import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ntl_app/features/profile/ui/pages/reusable_about_page.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  Future<void> _openWebsite() async {
    final Uri url = Uri.parse("https://nageshtouchlab.com/");

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReusablePage(
      title: "About",
      heading: "Terms and Conditions",
      subHeading: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black87,
            height: 1.6,
          ),
          children: [
            TextSpan(text: "Welcome to "),
            TextSpan(
              text: "Nagesh Touch Lab.",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: " By accessing or using our website ("),
            TextSpan(
              text: "https://nageshtouchlab.com/",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()..onTap = _openWebsite,
            ),
            TextSpan(
              text:
                  ") or our services, you agree to abide by the following Terms & Conditions. Please read this document carefully before proceeding.",
            ),
          ],
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          AboutSectionTile(
            index: 1,
            title: "Acceptance of Terms",
            description: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  height: 1.6,
                ),
                children: [
                  TextSpan(
                    text:
                        "By accessing or using our services, you agree to be bound by these terms and conditions.",
                  ),
                ],
              ),
            ),
          ),
          AboutSectionTile(
            index: 2,
            title: "Services",
            description: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  height: 1.6,
                ),
                children: [
                  TextSpan(
                    text:
                        "We provide diagnostic testing services. Results are for informational purposes and should be discussed with a healthcare provider.",
                  ),
                ],
              ),
            ),
          ),
          AboutSectionTile(
            index: 3,
            title: "User Responsibilities",
            description: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  height: 1.6,
                ),
                children: [
                  TextSpan(
                    text:
                        "Provide accurate information, follow sample collection guidelines, and keep your contact details updated.",
                  ),
                ],
              ),
            ),
          ),
          AboutSectionTile(
            index: 4,
            title: "Privacy",
            description: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  height: 1.6,
                ),
                children: [
                  TextSpan(
                    text:
                        "Your privacy is important to us. Please refer to our Privacy Policy for details on how we handle your data.",
                  ),
                ],
              ),
            ),
          ),
          AboutSectionTile(
            index: 5,
            title: "Payment & Refunds",
            description: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  height: 1.6,
                ),
                children: [
                  TextSpan(
                    text:
                        "Payments are processed securely. Refunds are subject to our refund policy.",
                  ),
                ],
              ),
            ),
          ),
          AboutSectionTile(
            index: 6,
            title: "Limitation of Liability",
            description: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  height: 1.6,
                ),
                children: [
                  TextSpan(
                    text:
                        "We are not liable for delays or issues arising from incorrect information or circumstances beyond our control.",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
