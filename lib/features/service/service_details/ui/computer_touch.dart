import 'package:flutter/material.dart';
import 'package:ntl_app/features/service/service_details/pages/service_details_page.dart';
import 'package:ntl_app/features/service/store/service.dart';

class ComputerTouchPage extends StatelessWidget {
  const ComputerTouchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ServiceDetailsPage(
      title: "Computer Touch: XRF Analysis",
      image: "assets/gold_machine.png",

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
          "Experience non-destructive X-ray fluorescence testing for precise elemental analysis of precious metals and alloys without damaging the sample. Our technology provides lab-quality results in seconds.",

      benefits: const [
        BenefitItem(
          icon: Icons.verified,
          title: "Non-destructive",
          desc:
              "Analysis leaves assets completely intact without scratches or acids.",
        ),
        BenefitItem(
          icon: Icons.warning_amber_rounded,
          title: "Highly Precise",
          desc:
              "Accuracy up to 0.01% for gold, silver, and platinum group metals.",
        ),
        BenefitItem(
          icon: Icons.flash_on,
          title: "Ultra Fast",
          desc: "Complete multi-element spectral results in under 30 seconds.",
        ),
      ],

      steps: const [
        StepItem(
          title: "Surface Preparation",
          desc:
              "The sample surface is cleaned to ensure the X-ray beam has direct contact with the metal lattice.",
        ),
        StepItem(
          title: "Excitation Phase",
          desc:
              "Primary X-rays from the analyzer displace electrons in the sample's inner shells, causing fluorescent X-rays to be emitted.",
        ),
        StepItem(
          title: "Spectral Fingerprinting",
          desc:
              "The energy of the emitted X-rays is measured and converted into a detailed elemental composition report.",
        ),
      ],

      analysis: [
        AnalysisItem(name: "Au (Gold)", value: 91.6, color: Colors.amber),
        AnalysisItem(name: "Ag (Silver)", value: 5.2, color: Colors.grey),
        AnalysisItem(name: "Cu (Copper)", value: 3.2, color: Colors.red),
      ],

      buttonText: "Inquire Now",

      onButtonTap: () {
        debugPrint("Inquire tapped");
      },
    );
  }
}
