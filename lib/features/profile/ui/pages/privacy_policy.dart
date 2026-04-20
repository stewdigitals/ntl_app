import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ntl_app/features/profile/ui/pages/reusable_about_page.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

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
      heading: "Privacy Policy",

      /// Clickable Rich Text 🔥
      subHeading: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black87,
            height: 1.6,
          ),
          children: [
            const TextSpan(text: "At "),
            const TextSpan(
              text: "Nagesh Touch Lab",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const TextSpan(
              text:
                  ", we are committed to protecting your personal information and ensuring transparency in how we collect, use, and safeguard your data. This Privacy Policy describes how we handle your information when you visit our website ",
            ),

            TextSpan(
              text: "https://nageshtouchlab.com/",
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()..onTap = _openWebsite,
            ),

            const TextSpan(text: " or use our services."),
          ],
        ),
      ),

      body: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          AboutSectionTile(
            index: 1,
            title: "Information we collect",
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
                        "We may collect the following types of information: Personal Information: Your name, email address, phone number, or any details provided through contact forms. Service-Related Information: Details related to metal testing, reports, and communication regarding services. Website Usage Data: IP address, browser type, pages visited, and time spent on the website (via analytics tools).",
                  ),
                ],
              ),
            ),
          ),
          AboutSectionTile(
            index: 2,
            title: "How We Use Your Information",
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
                        "Your information is used for the following purposes: To respond to your inquiries and provide customer support. To deliver accurate purity reports and service updates. To improve the performance and user experience of our website. For communication related to bookings, test results, or service updates. To maintain legal or administrative records.",
                  ),
                ],
              ),
            ),
          ),
          AboutSectionTile(
            index: 3,
            title: "Sharing of Information",
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
                        "We do not sell, trade, or rent your personal information to third parties. Your data may be shared only when necessary to provide our services, comply with legal obligations, or with your explicit consent.",
                  ),
                ],
              ),
            ),
          ),
          AboutSectionTile(
            index: 4,
            title: "Data Security",
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
                        "We take strict measures to safeguard your personal information. Access to your data is limited to authorized personnel only, and we use secure systems to protect against loss, misuse, or unauthorized access.",
                  ),
                ],
              ),
            ),
          ),
          AboutSectionTile(
            index: 5,
            title: "Cookies & Tracking",
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
                        "We may use cookies to enhance user experience, analyze traffic, and improve website performance. You can disable cookies through your browser settings if desired.",
                  ),
                ],
              ),
            ),
          ),
          AboutSectionTile(
            index: 6,
            title: "Third-Party Links",
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
                        "Our website may contain links to third-party sites. We are not responsible for the privacy practices or content of these external websites.",
                  ),
                ],
              ),
            ),
          ),
          AboutSectionTile(
            index: 7,
            title: "Your Rights",
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
                        "You have the right to: Request access to your stored personal data. Ask for corrections to inaccurate information. Request deletion of your personal data (where applicable). Withdraw consent for data usage.",
                  ),
                ],
              ),
            ),
          ),
          AboutSectionTile(
            index: 8,
            title: "Contact Information",
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
                        "If you have any concerns or questions about our privacy practices, feel free to contact us:\n Phone: +91 9326883179 / +91 9970288781 \n Email: nageshahc2019@gmail.com \n Website: ",
                  ),
                  TextSpan(
                    text: "https://nageshtouchlab.com/",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = _openWebsite,
                  ),
                ],
              ),
            ),
          ),
          AboutSectionTile(
            index: 9,
            title: "Changes to This Policy",
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
                        "We may update this Privacy Policy periodically. We will notify you of any significant changes by posting the new policy on our website with an updated effective date.",
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
