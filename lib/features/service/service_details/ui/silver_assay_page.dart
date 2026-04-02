import 'package:flutter/material.dart';
import 'package:ntl_app/features/service/service_details/pages/service_details_page.dart';
import 'package:ntl_app/features/service/store/service.dart';

class SilverAssayPage extends StatelessWidget {
  const SilverAssayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ServiceDetailsPage(
      title: "Silver Assay",
      image: "assets/silver_bars.jpg",

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
          "We provide comprehensive and reliable Silver Assay Services designed for individuals, businesses, and investors. Whether you need to evaluate silver jewellery, sell silverware, or verify the purity of bullion, our experienced assayers deliver accurate and trustworthy results. Our process ensures precision, transparency, and confidence at every step.",

      benefits: const [
        BenefitItem(
          icon: Icons.verified_user,
          title: "Specialized Expertise",
          desc:
              "Our skilled assayers have extensive experience in silver analysis, using advanced techniques and modern equipment.",
        ),
        BenefitItem(
          icon: Icons.biotech,
          title: "Swift turn around time",
          desc: "Get fast results without compromising on accuracy.",
        ),
        BenefitItem(
          icon: Icons.price_check,
          title: "Transparent Pricing",
          desc: "Clear, upfront pricing with no hidden charges.",
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
              "Advanced techniques are used to determine the silver content and calculate its exact purity.",
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
        debugPrint("Silver Inquiry Clicked");
      },
    );
  }
}
