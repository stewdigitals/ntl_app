import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ntl_app/core/components/card.dart';
import 'package:ntl_app/core/layout/layout.dart';
import 'package:ntl_app/features/home/ui/widgets/excellence_banner.dart';
import 'package:ntl_app/features/home/ui/widgets/home_banner.dart';
import 'package:ntl_app/features/home/ui/widgets/price_slider.dart';
import 'package:ntl_app/features/home/ui/widgets/stats_card.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return AppLayout(
      showAppBar: true,
      currentIndex: 0,
      onTabChange: (index) {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PriceSlider(),
          AssayBanner(),
          StatsCard(),
          SizedBox(height: 10),
          _buildActionGrid(),
          buildServices(),
          ExcellenceBanner(),
        ],
      ),
    );
  }

  Widget _buildActionGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(child: _appointmentCard()),
          const SizedBox(width: 12),
          Expanded(child: _estimateCard()),
        ],
      ),
    );
  }

  Widget _appointmentCard() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          color: Colors.primary,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.primary.withValues(alpha: 0.2),
              offset: const Offset(0, 4),
              blurRadius: 6,
              spreadRadius: -4,
            ),
            BoxShadow(
              color: Colors.primary.withValues(alpha: 0.2),
              offset: const Offset(0, 10),
              blurRadius: 15,
              spreadRadius: -3,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.calendar_month, color: Colors.white, size: 26),
            SizedBox(height: 8),
            Text(
              "Book\nAppointment",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _estimateCard() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          color: Colors.primary.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.primary.withValues(alpha: 0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.calculate, color: Colors.primary, size: 26),
            SizedBox(height: 8),
            Text(
              "Get\nEstimate",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.primary,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildServices() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Our Services",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "View All",
                  style: TextStyle(
                    color: Colors.primary,
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),

          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.2,
            children: [
              ServiceCard(
                title: "Gold Assay",
                subtitle: "Fire assay analysis for 99.9% purity verification.",
                icon: Icons.workspace_premium,
                bgColor: const Color(0xFFFDECEC),
                titleColor: Colors.primary,
                iconColor: Colors.primary,
                borderColor: Colors.primary.withValues(alpha: 0.1),
                iconBgColor: Colors.transparent,
                onTap: () {},
              ),

              ServiceCard(
                title: "Silver Assay",
                subtitle: "Accurate silver content determination.",
                icon: Icons.circle,
                bgColor: const Color(0xFFFFF6DB),
                titleColor: Color(0xFFD4AF35),
                subtitleColor: Color(0xFF4C4C4C),
                iconColor: Color(0xFFD4AF35),
                borderColor: Color(0xFFD4AF35).withValues(alpha: 0.2),
                iconBgColor: Colors.transparent,
              ),

              ServiceCard(
                title: "Computer Touch",
                subtitle: "XRF non-destructive laser spectroscopy.",
                icon: Icons.computer,
                bgColor: Colors.primary.withValues(alpha: 0.05),
                titleColor: Colors.primary,
                iconColor: Colors.primary,
                borderColor: Colors.primary.withValues(alpha: 0.1),
                iconBgColor: Colors.transparent,
              ),

              ServiceCard(
                title: "Hallmarking",
                subtitle: "BIS certified laser marking services.",
                icon: Icons.verified,
                bgColor: Colors.primary.withValues(alpha: 0.05),
                titleColor: Colors.primary,
                iconColor: Colors.primary,
                borderColor: Colors.primary.withValues(alpha: 0.1),
                iconBgColor: Colors.transparent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
