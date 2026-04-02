import 'package:flutter/material.dart';
import 'package:ntl_app/core/components/card.dart';
import 'package:ntl_app/core/components/custom_topbar.dart';
import 'package:ntl_app/core/layout/layout.dart';

class ReportsVaultPage extends StatelessWidget {
  const ReportsVaultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      currentIndex: 3,
      onTabChange: (index) {},
      child: Column(
        children: [
          /// 🔴 STICKY TOP BAR
          CustomTopAppBar(
            title: "Digital Reports Vault",
            showRightIcon: true,
            rightIcon: Icons.notifications_none,
            showBack: true,
            onBack: () {
              Navigator.pop(context);
            },
          ),

          /// 🔽 SCROLLABLE CONTENT ONLY
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _searchBar(),
                        const SizedBox(height: 12),
                        _filters(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  _sectionTitle("Sample Reports"),
                  const SizedBox(height: 12),

                  _reportCard(
                    "Gold Bar 999",
                    "ID: NT-8829-GB",
                    "assets/gold_bar.jpg",
                  ),
                  _reportCard(
                    "Wedding Band",
                    "ID: NT-4412-WB",
                    "assets/ring.jpg",
                  ),
                  _reportCard(
                    "Bullion Coin",
                    "ID: NT-2930-BC",
                    "assets/coin.jpg",
                  ),

                  const SizedBox(height: 20),
                  _trustedSection(),
                  const SizedBox(height: 20),
                  _ctaCard(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w900,
        color: Colors.black,
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFE2E8F0)),
      ),
      child: const TextField(
        decoration: InputDecoration(
          fillColor: Colors.transparent,
          icon: Icon(Icons.search),
          hintText: "Search report ID or metal purity...",
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _filters() {
    return Row(
      children: [
        _chip("All Reports", true),
        _chip("Purity Tests", false),
        _chip("Hallmark", false),
      ],
    );
  }

  Widget _chip(String text, bool active) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: active ? Colors.accent : Color(0xFFE2E8F0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: active ? Colors.white : Colors.black,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _reportCard(String title, String id, String image) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          /// IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(image, height: 50, width: 50, fit: BoxFit.cover),
          ),

          const SizedBox(width: 10),

          /// TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
                Text(
                  id,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),

          /// BUTTON
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.accent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              "View Sample",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _trustedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("Why Our Reports are Trusted"),

        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.2,
          children: [
            _trustedCard(
              "BIS Standards",
              "Globally recognized hallmarking.",
              Icons.verified_outlined,
            ),
            _trustedCard(
              "XRF Precision",
              "Non-destructive purity analysis.",
              Icons.precision_manufacturing,
            ),
            _trustedCard(
              "Anti-Tamper",
              "Blockchain-backed security.",
              Icons.lock_outline,
            ),
            _trustedCard(
              "Expert Certified",
              "Verified by senior assayers.",
              Icons.workspace_premium_outlined,
            ),
          ],
        ),
      ],
    );
  }

  Widget _trustedCard(String title, String subtitle, IconData icon) {
    return ServiceCard(
      title: title,
      subtitle: subtitle,
      icon: icon,
      bgColor: Colors.white,
      iconColor: Colors.red,
      borderColor: Colors.transparent,
    );
  }

  Widget _ctaCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0B1220), Color(0xFF1E293B)],
        ),
      ),
      child: Stack(
        children: [
          /// 🌀 SUBTLE BACKGROUND DESIGN
          Positioned(
            right: -20,
            bottom: -20,
            child: Opacity(
              opacity: 0.08,
              child: Icon(
                Icons.settings, // or any abstract icon
                size: 120,
                color: Colors.white,
              ),
            ),
          ),

          /// 📄 CONTENT
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// TITLE
                const Text(
                  "Certify Your Gold",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 8),

                /// SUBTITLE
                const Text(
                  "Get accurate purity reports and digital vaulting for your precious metals today.",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 16),

                /// 🔴 CTA BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Book an Assay Appointment",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
