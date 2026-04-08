import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ntl_app/core/components/card.dart';
import 'package:ntl_app/core/layout/layout.dart';
import 'package:ntl_app/features/home/ui/widgets/excellence_banner.dart';
import 'package:ntl_app/features/home/ui/widgets/home_banner.dart';
import 'package:ntl_app/features/home/ui/widgets/price_slider.dart';
import 'package:ntl_app/features/home/ui/widgets/stats_card.dart';
import 'package:ntl_app/features/service/provider/service_notifier.dart';
import 'package:ntl_app/features/service/service_details/pages/service_details_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(servicesProvider.notifier).fetchServices();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      showAppBar: true,
      child: Column(
        children: [
          PriceSlider(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AssayBanner(),
                  StatsCard(),
                  SizedBox(height: 10),
                  _buildActionGrid(),
                  buildServices(),
                  SizedBox(height: 10),
                  ExcellenceBanner(),
                ],
              ),
            ),
          ),
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
    final state = ref.watch(servicesProvider);
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
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.2,
            children: state.isLoading
                ? List.generate(
                    4,
                    (_) => const Center(child: CircularProgressIndicator()),
                  )
                : state.data.map((service) {
                    return ServiceCard(
                      title: service.title,
                      subtitle: service.subtitle,
                      icon: Icons.miscellaneous_services,
                      bgColor: Colors.primary.withValues(alpha: 0.05),
                      titleColor: Colors.primary,
                      iconColor: Colors.primary,
                      borderColor: Colors.primary.withValues(alpha: 0.1),
                      iconBgColor: Colors.transparent,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ServiceDetailsPage(
                              title: service.title,
                              subtitle: service.subtitle,
                              image: service.image,
                              tags: service.tags,
                              description: service.description,
                              videoUrl: service.videoUrl,
                              buttonText: "Book Service",
                              onButtonTap: () {},
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
          ),
        ],
      ),
    );
  }
}
