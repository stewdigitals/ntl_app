import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ntl_app/core/components/custom_topbar.dart';
import 'package:ntl_app/core/layout/layout.dart';
import 'package:ntl_app/features/service/ui/widgets/assay_section.dart';
import 'package:ntl_app/features/service/ui/widgets/goldloan_section.dart';
import 'package:ntl_app/features/service/ui/widgets/repairs_section.dart';
import 'package:ntl_app/features/service/ui/widgets/specialized_section.dart';
import 'package:ntl_app/features/service/ui/widgets/top_nav.dart';

class ServicePage extends ConsumerStatefulWidget {
  const ServicePage({super.key});

  @override
  ConsumerState<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends ConsumerState<ServicePage> {
  int activeIndex = 0;

  final ScrollController scrollController = ScrollController();

  final GlobalKey assayKey = GlobalKey();
  final GlobalKey goldLoanKey = GlobalKey();
  final GlobalKey specializedKey = GlobalKey();
  final GlobalKey repairsKey = GlobalKey();

  late final List<GlobalKey> keys;

  @override
  void initState() {
    super.initState();

    keys = [assayKey, goldLoanKey, specializedKey, repairsKey];

    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    double offset = scrollController.offset;

    for (int i = 0; i < keys.length; i++) {
      final context = keys[i].currentContext;
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

    // 🔥 force last section
    if (offset >= scrollController.position.maxScrollExtent - 1) {
      if (activeIndex != keys.length - 1) {
        setState(() {
          activeIndex = keys.length - 1;
        });
      }
    }
  }

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

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose(); // ✅ important
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      showAppBar: false,
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            CustomTopAppBar(
              title: "All Services",
              showBack: true,
              showRightIcon: true,
              rightIcon: Icons.notifications_none,
              onRightTap: () {},
              onBack: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const MainScreen(initialIndex: 0),
                ),
                (route) => false,
              ),
            ),

            TopNavBar(
              keys: keys, // ✅ use local keys
              activeIndex: activeIndex,
              onTap: (key) {
                final index = keys.indexOf(key);

                setState(() {
                  activeIndex = index;
                });

                scrollToSection(key);
              },
            ),

            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    Container(key: assayKey, child: const AssayingSection()),
                    Container(key: goldLoanKey, child: const GoldLoanSection()),
                    Container(
                      key: specializedKey,
                      child: const SpecializedSection(),
                    ),
                    Container(key: repairsKey, child: const RepairsSection()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
