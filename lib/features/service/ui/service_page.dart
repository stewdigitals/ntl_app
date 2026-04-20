import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ntl_app/core/components/custom_topbar.dart';
import 'package:ntl_app/core/layout/layout.dart';
import 'package:ntl_app/features/service/ui/widgets/assay_section.dart';
import 'package:ntl_app/features/service/ui/widgets/goldloan_section.dart';
import 'package:ntl_app/features/service/ui/widgets/repairs_section.dart';
import 'package:ntl_app/features/service/ui/widgets/specialized_section.dart';
import 'package:ntl_app/features/service/ui/widgets/top_nav.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Widget buildAddressSection() {
    final locations = [
      {
        "title": "Ulhasnagar Branch",
        "city": "Ulhasnagar",
        "address":
            "Shop No 06 Ground Floor, Gold Field Market, 2 Sonar Galli, near SK Tool Siru Chowk, Maharashtra 421002",
        "button": "Open Map",
        "url": "https://maps.app.goo.gl/HKdGpTTAvQopJXfb6",
      },
      {
        "title": "Kalyan Branch",
        "city": "Kalyan",
        "address":
            "Juna Janata Bank, near Pappu Builder Office, Kolsewadi, Kalyan, Maharashtra 421306",
        "button": "Open Map",
        "url": "https://maps.app.goo.gl/87nyuoDczCQwfJaU8",
      },
      {
        "title": "Thane West Branch",
        "city": "Thane",
        "address":
            "Shop No. 9, Ground Floor, Shashikant Niwas, Gheladevji Chowk, BazarPeth Rd, Kalyan (W), Maharashtra 421301",
        "button": "Open Map",
        "url": "https://maps.app.goo.gl/FgrZLvmG8KgrKrDc7",
      },
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 20, 16, 30),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: const LinearGradient(
          colors: [Color(0xff0B1220), Color(0xff172033), Color(0xff243247)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .18),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header ✨
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.amber.withValues(alpha: .14),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.storefront_rounded,
                  color: Colors.amber,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Visit Our Stores",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "3 Locations Available",
                      style: TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          /// Accordion
          Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: ExpansionPanelList.radio(
              elevation: 0,
              expandedHeaderPadding: EdgeInsets.zero,
              animationDuration: const Duration(milliseconds: 350),
              children: locations.map((item) {
                return ExpansionPanelRadio(
                  value: item["title"]!,
                  backgroundColor: Colors.white.withValues(alpha: .05),

                  headerBuilder: (context, isExpanded) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 44,
                            width: 44,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.amber.withValues(alpha: .12),
                            ),
                            child: const Icon(
                              Icons.location_on_rounded,
                              color: Colors.amber,
                              size: 22,
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item["title"]!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  item["city"]!,
                                  style: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },

                  body: Container(
                    margin: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: .04),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: .05),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Store Address",
                          style: TextStyle(
                            color: Colors.amber,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          item["address"]!,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                            height: 1.55,
                          ),
                        ),

                        const SizedBox(height: 14),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              final Uri mapUrl = Uri.parse(item["url"]!);

                              if (await canLaunchUrl(mapUrl)) {
                                await launchUrl(
                                  mapUrl,
                                  mode: LaunchMode.externalApplication,
                                );
                              }
                            },
                            icon: const Icon(Icons.map_outlined, size: 18),
                            label: Text(item["button"]!),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber,
                              foregroundColor: Colors.black,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
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
                    buildAddressSection(),
                    SizedBox(height: 250),
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
