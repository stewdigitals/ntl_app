import 'package:flutter/material.dart';
import 'package:ntl_app/features/service/service_details/pages/service_details_page.dart';
import 'package:ntl_app/features/service/store/service.dart';

class GoldAssayPage extends StatelessWidget {
  const GoldAssayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ServiceDetailsPage(
      title: "Gold Assay",
      image: "assets/gold_jewellery.png",

      tags: [
        TagItem(
          text: "Premium Service",
          textColor: Colors.accent,
          color: Colors.accent.withValues(alpha: 0.2),
          borderColor: Colors.accent,
        ),
        TagItem(
          text: "Certified",
          textColor: Colors.primary,
          color: Colors.primary.withValues(alpha: 0.3),
          borderColor: Colors.primary,
        ),
      ],

      description:
          "We offer reliable Gold Assay Services for individuals, businesses, and jewelers. Whether you're selling gold, verifying authenticity, or checking purity, our expert team delivers accurate results using advanced techniques, ensuring precision and complete transparency.",

      benefits: const [
        BenefitItem(
          icon: Icons.verified_user,
          title: "Specialized Expertise",
          desc:
              "Our skilled assayers have extensive experience in gold analysis.",
        ),
        BenefitItem(
          icon: Icons.biotech_outlined,
          title: "Swift Turnaround",
          desc: "Fast results without compromising accuracy.",
        ),
        BenefitItem(
          icon: Icons.price_check,
          title: "Transparent Pricing",
          desc: "Clear pricing with no hidden charges.",
        ),
      ],

      steps: const [
        StepItem(
          title: "Sample Collection & Preparation",
          desc:
              "A small sample is taken and carefully cleaned to remove impurities, ensuring accurate testing.",
        ),
        StepItem(
          title: "Testing & Analysis",
          desc:
              "Advanced techniques are used to determine the gold content and calculate its exact purity.",
        ),
        StepItem(
          title: "Verification & Reporting",
          desc:
              "Results are verified for accuracy and provided in a clear, detailed report.",
        ),
      ],

      analysis: const [
        AnalysisItem(name: "Au (Gold)", value: 91.6, color: Colors.accent),
        AnalysisItem(name: "Ag (Silver)", value: 5.2, color: Colors.icon),
        AnalysisItem(name: "Cu (Copper)", value: 3.2, color: Colors.primary),
      ],

      buttonText: "Inquire Now",

      onButtonTap: () {
        debugPrint("Gold Inquiry Clicked");
      },
    );
  }
}
