import 'package:flutter/material.dart';
import 'package:ntl_app/core/components/card.dart';
import 'package:ntl_app/core/components/coming_soon_badge.dart';
import 'package:ntl_app/features/service/ui/widgets/service_title.dart';

class GoldLoanSection extends StatelessWidget {
  const GoldLoanSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              buildTitle("Gold Loan Services", Colors.primary),
              const SizedBox(width: 8),
              const ComingSoonBadge(),
            ],
          ),

          // 🧩 GRID
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 1.2,
            children: [
              ServiceCard(
                title: "Gold Loan",
                subtitle: "Instant cash against your gold assets.",
                icon: Icons.payments,
                iconColor: Colors.red,
                iconBgColor: const Color(0xFFFDECEC),
                borderColor: Colors.grey.shade300,
                onTap: () {},
              ),

              // 🟡 NPA Gold Loan
              ServiceCard(
                title: "NPA Gold Loan",
                subtitle: "Release and settle overdue gold loans.",
                icon: Icons.account_balance,
                iconColor: const Color(0xFFD4AF35),
                iconBgColor: const Color(0xFFFFF6DB),
                borderColor: Colors.grey.shade300,
                onTap: () {},
              ),

              // 🔁 Money On Gold
              ServiceCard(
                title: "Money On Gold",
                subtitle: "Competitive rates for your gold jewelry.",
                icon: Icons.currency_exchange,
                iconColor: Colors.red,
                iconBgColor: const Color(0xFFFDECEC),
                borderColor: Colors.grey.shade300,
                onTap: () {},
              ),

              // ⚙️ Gold Loan Problem
              ServiceCard(
                title: "Gold Loan Problem",
                subtitle: "Expert solutions for loan disputes.",
                icon: Icons.help_outline,
                iconColor: Colors.black54,
                iconBgColor: const Color(0xFFE5E7EB),
                borderColor: Colors.grey.shade300,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
