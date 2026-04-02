import 'package:flutter/material.dart';
import 'package:ntl_app/features/service/ui/widgets/assay_section.dart';
import 'package:ntl_app/features/service/ui/widgets/goldloan_section.dart';
import 'package:ntl_app/features/service/ui/widgets/repairs_section.dart';
import 'package:ntl_app/features/service/ui/widgets/specialized_section.dart';

class TopNavBar extends StatefulWidget {
  final Function(GlobalKey) onTap;
  final List<GlobalKey> keys;
  final int activeIndex;

  const TopNavBar({
    super.key,
    required this.onTap,
    required this.keys,
    required this.activeIndex,
  });

  @override
  State<TopNavBar> createState() => _TopNavBarState();
}

class _TopNavBarState extends State<TopNavBar> {
  final tabs = ["Assaying", "Gold Loan", "Specialized", "Repairs"];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(tabs.length, (index) {
          return _tabItem(tabs[index], index);
        }),
      ),
    );
  }

  Widget _tabItem(String title, int index) {
    final isActive = widget.activeIndex == index;

    return GestureDetector(
      onTap: () {
        widget.onTap(widget.keys[index]);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isActive ? Colors.red : Colors.black,
              ),
              child: Text(title),
            ),

            const SizedBox(height: 6),

            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: 2,
              width: isActive ? 40 : 0, // 👈 magic
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final ScrollController scrollController = ScrollController();

final GlobalKey assayKey = GlobalKey();
final GlobalKey goldLoanKey = GlobalKey();
final GlobalKey specializedKey = GlobalKey();
final GlobalKey repairsKey = GlobalKey();

void scrollToSection(GlobalKey key) {
  final context = key.currentContext;
  if (context != null) {
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}

Widget buildBody() {
  return Column(
    children: [
      Container(key: assayKey, child: const AssayingSection()),
      Container(key: goldLoanKey, child: const GoldLoanSection()),
      Container(key: specializedKey, child: const SpecializedSection()),
      Container(key: repairsKey, child: const RepairsSection()),
    ],
  );
}
