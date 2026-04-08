import 'package:flutter/material.dart';
import 'package:ntl_app/core/components/custom_topbar.dart';
import 'package:ntl_app/core/layout/layout.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  int selectedFilter = 0;

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            CustomTopAppBar(
              title: "Testing Reports",
              showBack: true,
              showBackBg: true,
              showRightIcon: true,
              rightIcon: Icons.notifications_none,
            ),
            const SizedBox(height: 10),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ReportSearchBar(),
            ),

            const SizedBox(height: 12),

            // 🎯 Filters
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ReportFilters(
                selectedIndex: selectedFilter,
                onTap: (i) => setState(() => selectedFilter = i),
              ),
            ),

            const SizedBox(height: 12),

            // 📊 LIST
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _header(),

                    ReportCard(
                      id: "#NTL-2023-8842",
                      date: "Oct 24, 2023 · 11:45 AM",
                      purity: "91.6%",
                      karat: "22 Karat",
                      isGold: true,
                    ),

                    ReportCard(
                      id: "#NTL-2023-8839",
                      date: "Oct 22, 2023 · 02:15 PM",
                      purity: "99.9%",
                      karat: "Fine Silver",
                      isGold: false,
                    ),

                    ReportCard(
                      id: "#NTL-2023-8831",
                      date: "Oct 19, 2023 · 10:20 AM",
                      purity: "75.0%",
                      karat: "18 Karat",
                      isGold: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          const Text(
            "RECENT REPORTS",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
          ),
          const Spacer(),
          Text(
            "12 Reports Found",
            style: TextStyle(
              fontSize: 11,
              color: Colors.red,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class ReportSearchBar extends StatelessWidget {
  const ReportSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey.shade500),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search Report ID or Metal...",
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ReportFilters extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const ReportFilters({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final filters = ["All Dates", "Gold", "Silver", "Last 30 Days"];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(filters.length, (index) {
          final isActive = selectedIndex == index;

          return GestureDetector(
            onTap: () => onTap(index),
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isActive ? Colors.amber : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Text(
                filters[index],
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: isActive ? Colors.white : Colors.black,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class ReportCard extends StatelessWidget {
  final String id;
  final String date;
  final String purity;
  final String karat;
  final bool isGold;
  final VoidCallback? onDownload;

  const ReportCard({
    super.key,
    required this.id,
    required this.date,
    required this.purity,
    required this.karat,
    required this.isGold,
    this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    final accent = isGold ? Colors.amber : Colors.blueGrey;
    final bg = accent.withValues(alpha: 0.08);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: accent.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔝 TOP ROW
          Row(
            children: [
              Expanded(
                child: Text(
                  id,
                  style: TextStyle(fontWeight: FontWeight.w600, color: accent),
                ),
              ),
              Text(
                date,
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
              const SizedBox(width: 8),
              _tag(isGold ? "Gold" : "Silver", accent),
            ],
          ),

          const SizedBox(height: 10),

          // 📊 LABEL
          Text(
            "Purity Result",
            style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
          ),

          const SizedBox(height: 6),

          // 🔥 VALUE + DOWNLOAD
          Row(
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: purity,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: isGold ? Colors.red : Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: " ($karat)",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              GestureDetector(
                onTap: onDownload,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.download, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: TextStyle(fontSize: 11, color: color)),
    );
  }
}
