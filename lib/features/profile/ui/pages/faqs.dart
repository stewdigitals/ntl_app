import 'package:flutter/material.dart';
import 'package:ntl_app/features/profile/ui/pages/reusable_about_page.dart';

class FaqsPage extends StatelessWidget {
  const FaqsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ReusablePage(
      title: "About",
      heading: "FAQ",
      subHeading: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black87,
            height: 1.6,
          ),
          children: const [
            TextSpan(
              text:
                  "Everything you need to know about Nagesh Touch Lab services, reports, and account management.",
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
            title: "What is gold assay testing?",
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
                        "Gold assay testing is a scientific method used to determine the purity or karat of gold. It involves analyzing the metal composition to verify its actual gold content, whether it's 24K, 22K, 18K, or any other karat.",
                  ),
                ],
              ),
            ),
          ),
          AboutSectionTile(
            index: 2,
            title: "Why should I get my gold assayed?",
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
                        "Getting your gold assayed ensures you receive fair value, whether selling, exchanging, or taking a loan. It verifies purity and prevents undervaluation.",
                  ),
                ],
              ),
            ),
          ),
          AboutSectionTile(
            index: 3,
            title: "How is gold purity measured during assay?",
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
                        "Gold purity is typically measured in karats or percentage. We use advanced techniques like XRF (X-Ray Fluorescence) testing and fire assay (if applicable) for precise results.",
                  ),
                ],
              ),
            ),
          ),
          AboutSectionTile(
            index: 4,
            title: "How long does a gold assay test take?",
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
                        "Most tests take just 5–15 minutes, depending on the item and method used. We aim to provide quick, accurate results while you wait.",
                  ),
                ],
              ),
            ),
          ),
          AboutSectionTile(
            index: 5,
            title: "Do I need an appointment for testing?",
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
                        "Walk-ins are welcome, but we recommend booking an appointment for faster service—especially during peak hours.",
                  ),
                ],
              ),
            ),
          ),
          AboutSectionTile(
            index: 6,
            title: "Where is your assay lab located?",
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
                        "We are located at [Insert Address]. You can also call us at [Insert Phone Number] or WhatsApp for directions and service queries.",
                  ),
                ],
              ),
            ),
          ),
          AboutSectionTile(
            index: 7,
            title: "Is gold assay testing expensive?",
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
                        "Our services are priced affordably, starting from just ₹[Insert price]. We offer transparent pricing with no hidden charges.",
                  ),
                ],
              ),
            ),
          ),
          AboutSectionTile(
            index: 8,
            title: "Do you issue certificates after testing?",
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
                        "Yes, we provide detailed assay reports or certificates showing the karat, purity percentage, and weight of your gold.",
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
