import 'package:flutter/material.dart';
import 'package:ntl_app/features/service/service_details/pages/service_details_page.dart';
import 'package:ntl_app/features/service/store/service.dart';

class LaserSolderingPage extends StatelessWidget {
  const LaserSolderingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ServiceDetailsPage(
      title: "Laser Soldering",
      image: "assets/laser_soldering.png",

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
          "We offer reliable Laser Soldering Services for individuals, businesses, and jewelers. Whether you're selling gold, verifying authenticity, or checking purity, our expert team delivers accurate results using advanced techniques, ensuring precision and complete transparency.",

      benefits: const [
        BenefitItem(
          icon: Icons.verified_user,
          title: "High Precision",
          desc:
              "Allows accurate, targeted soldering without affecting surrounding areas—ideal for delicate work.",
        ),
        BenefitItem(
          icon: Icons.biotech,
          title: "Efficiency & Speed",
          desc:
              "Quick process with consistent results, improving productivity and turnaround time.",
        ),
        BenefitItem(
          icon: Icons.price_check,
          title: "Strong, Clean Joints",
          desc:
              "Produces durable bonds with a neat finish, requiring little to no post-processing.",
        ),
      ],

      steps: const [
        StepItem(
          title: "Surface Preparation",
          desc:
              "The gold or silver piece is cleaned and aligned to ensure a proper and precise joint.",
        ),
        StepItem(
          title: "Laser Soldering Process",
          desc:
              "A focused laser beam melts the solder (and a small area of the metal), creating a precise bond with minimal heat spread.",
        ),
        StepItem(
          title: "Cooling & Finishing",
          desc:
              "The joint cools quickly, forming a strong, clean bond with little to no need for additional polishing.",
        ),
      ],

      analysis: const [
        AnalysisItem(name: "Au (Gold)", value: 91.6, color: Colors.amber),
        AnalysisItem(name: "Ag (Silver)", value: 5.2, color: Colors.grey),
        AnalysisItem(name: "Cu (Copper)", value: 3.2, color: Colors.red),
      ],

      buttonText: "Inquire Now",

      onButtonTap: () {
        debugPrint("Laser Soldering Inquiry Clicked");
      },
    );
  }
}
