import 'package:flutter/material.dart';
import 'package:ntl_app/core/components/horizontal_card.dart';
import 'package:ntl_app/features/service/ui/widgets/service_title.dart';

class AssayingSection extends StatelessWidget {
  const AssayingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: _buildAssayList(),
    );
  }

  Widget _buildAssayList() {
    return Column(
      children: [
        buildTitle("Assaying", Color(0xFFD4AF35)),
        SizedBox(height: 20),
        HorizontalCard(
          title: "Gold Assay",
          subtitle: "Accurate karat determination & purity analysis.",
          icon: Icons.workspace_premium,
          iconGradient: const LinearGradient(
            colors: [Color(0xFFD4AF37), Color(0xFFE5C16D)],
          ),
          showIconShadow: true,
          iconColor: Colors.white,
        ),

        HorizontalCard(
          title: "Silver Assay",
          subtitle: "Precise silver purity analysis for ornaments.",
          icon: Icons.layers,
          iconBg: const Color(0xFFE5E7EB),
          iconColor: Colors.black54,
        ),

        HorizontalCard(
          title: "Computer Touch / XRF",
          subtitle: "Non-destructive X-Ray Fluorescence analysis.",
          icon: Icons.biotech, // 🔥 better match
          iconBg: const Color(0xFF0F172A),
          iconColor: Colors.white,
          showIconShadow: true,
        ),

        HorizontalCard(
          title: "Metal Testing",
          subtitle: "Comprehensive composition analysis for metals.",
          icon: Icons.engineering, // 🔥 best fit
          iconBg: const Color(0xFFE5E7EB),
          iconColor: Colors.black54,
        ),
      ],
    );
  }
}
