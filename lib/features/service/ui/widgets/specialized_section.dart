import 'package:flutter/material.dart';
import 'package:ntl_app/core/components/card.dart';
import 'package:ntl_app/features/service/ui/widgets/service_title.dart';

class SpecializedSection extends StatelessWidget {
  const SpecializedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitle("Specialized Technical Services", Color(0xFF94A3B8)),

          const SizedBox(height: 16),

          // 🌟 FEATURE CARD
          const _FeatureCard(),

          const SizedBox(height: 16),

          // 🧩 MINI GRID
          Row(
            children: [
              Expanded(
                child: ServiceCard(
                  title: "Laser Soldering",
                  subtitle: "High-precision jewelry joint repair.",
                  icon: Icons.wb_sunny_outlined,
                  iconColor: Colors.amber,
                  iconBgColor: const Color(0xFF0F172A),
                  borderColor: Colors.grey.shade300,
                  onTap: () {},
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: ServiceCard(
                  title: "Laser Marking",
                  subtitle: "Permanent engraving and branding.",
                  icon: Icons.edit,
                  iconColor: Colors.amber,
                  iconBgColor: const Color(0xFF0F172A),
                  borderColor: Colors.grey.shade300,
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5EFE4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFD4AF35).withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 52,
            width: 52,
            decoration: const BoxDecoration(
              color: Color(0xFFD4AF35),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.verified, color: Colors.white),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Hallmarking Center",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4),
                Text(
                  "Official BIS hallmarking services for purity certification.",
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),
                SizedBox(height: 8),
                Text(
                  "GET CERTIFIED →",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MiniCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const MiniCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F6F6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.amber, size: 22),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
