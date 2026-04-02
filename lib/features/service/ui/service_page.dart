import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ntl_app/core/components/custom_topbar.dart';
import 'package:ntl_app/core/layout/layout.dart';
import 'package:ntl_app/features/service/ui/widgets/top_nav.dart';

class ServicePage extends ConsumerStatefulWidget {
  const ServicePage({super.key});

  @override
  ConsumerState<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends ConsumerState<ServicePage> {
  int activeIndex = 0;
  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final sections = [assayKey, goldLoanKey, specializedKey, repairsKey];

    double offset = scrollController.offset;

    for (int i = 0; i < sections.length; i++) {
      final context = sections[i].currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox;
        final sectionOffset =
            box.localToGlobal(Offset.zero).dy + scrollController.offset;

        if (offset >= sectionOffset - 300) {
          if (activeIndex != i) {
            setState(() {
              activeIndex = i;
            });
          }
        }
      }
    }

    // 🔥 FORCE last section when near bottom
    if (offset >= scrollController.position.maxScrollExtent - 1) {
      if (activeIndex != sections.length - 1) {
        setState(() {
          activeIndex = sections.length - 1;
        });
      }
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      showAppBar: false,
      currentIndex: 1,
      onTabChange: (index) {},
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            // 🧱 STICKY HEADER
            CustomTopAppBar(
              title: "All Services",
              showBack: true,
              showRightIcon: true,
              rightIcon: Icons.notifications_none,
              onRightTap: () {},
            ),

            TopNavBar(
              keys: [assayKey, goldLoanKey, specializedKey, repairsKey],
              onTap: (key) => scrollToSection(key),
              activeIndex: activeIndex,
            ),

            // 📜 ONLY THIS SCROLLS
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                child: buildBody(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
