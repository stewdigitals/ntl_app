import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:ntl_app/features/service/ui/widgets/service_title.dart';

class RepairsSection extends StatelessWidget {
  const RepairsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitle("Jewellery Repairs", Colors.secondary),

          const SizedBox(height: 16),

          RepairCard(
            title: "Jewellery Repairing",
            subtitle: "Expert restoration for all types of precious ornaments.",
            icon: Icons.build,
            onTap: () {},
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}

class RepairCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onTap;

  const RepairCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: DottedBorder(
            options: RoundedRectDottedBorderOptions(
              radius: const Radius.circular(17),
              dashPattern: const [6, 3],
              strokeWidth: 2,
              color: Colors.grey.shade300,
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  // 🔘 ICON BUBBLE
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5E7EB),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: Colors.black54),
                  ),

                  const SizedBox(width: 14),

                  // 📝 TEXT
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 300),
      ],
    );
  }
}
