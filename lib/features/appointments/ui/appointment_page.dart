// ignore_for_file: unnecessary_cast

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:ntl_app/core/components/button.dart';
import 'package:ntl_app/core/components/custom_topbar.dart';
import 'package:ntl_app/core/layout/layout.dart';
import 'package:ntl_app/features/service/booking/provider/booking_provider.dart';
import 'package:ntl_app/features/service/booking/store/booking.dart';
import 'package:ntl_app/features/service/booking/ui/booking_flow_page.dart';

class MyAppointmentsPage extends ConsumerStatefulWidget {
  const MyAppointmentsPage({super.key});

  @override
  ConsumerState<MyAppointmentsPage> createState() => _MyAppointmentsPageState();
}

class _MyAppointmentsPageState extends ConsumerState<MyAppointmentsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);

    Future.microtask(() {
      ref.read(appointmentControllerProvider.notifier).fetchAppointments();
    });
  }

  @override
  Widget build(BuildContext context) {
    final appointments = ref.watch(appointmentStoreProvider).appointments;

    final cancelled = appointments.where((e) {
      return (e['status'] ?? '').toString().toLowerCase() == 'cancelled';
    }).toList();

    final now = DateTime.now();

    final upcoming = appointments.where((e) {
      if ((e['status'] ?? '').toString().toLowerCase() == 'cancelled') {
        return false;
      }

      final date = DateTime.parse(e['appointmentDate']);
      final time = e['slotTime'];

      final parts = time.split(':');
      final dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        int.parse(parts[0]),
        int.parse(parts[1]),
      );

      return !dateTime.isBefore(now);
    }).toList();

    final past = appointments.where((e) {
      if ((e['status'] ?? '').toString().toLowerCase() == 'cancelled') {
        return false;
      }

      final date = DateTime.parse(e['appointmentDate']);
      final time = e['slotTime'];

      final parts = time.split(':');
      final dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        int.parse(parts[0]),
        int.parse(parts[1]),
      );

      return dateTime.isBefore(now);
    }).toList();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          CustomTopAppBar(
            title: "My Appointments",
            showBack: true,
            onBack: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => const MainScreen(initialIndex: 0),
              ),
              (route) => false,
            ),
          ),
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.primary,
            labelColor: Colors.primary,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: "Upcoming"),
              Tab(text: "Past"),
              Tab(text: "Cancelled"),
            ],
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildList(upcoming, showCancel: true),
                _buildList(past, showCancel: false),
                _buildList(cancelled, showCancel: false),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: CustomElevatedButton(
              text: "Book New Appointment",
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => BookingPage()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(List data, {required bool showCancel}) {
    if (data.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🎨 Icon Container
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.primary.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.calendar_today_rounded,
                size: 40,
                color: Colors.primary,
              ),
            ),

            const SizedBox(height: 20),

            // 🧠 Title
            const Text(
              "No Appointments Yet",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 6),

            // 💬 Subtitle
            const Text(
              "Your bookings will appear here",
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),

            const SizedBox(height: 20),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => BookingPage()),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Book Appointment",
                  style: TextStyle(
                    color: Colors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];

        return GestureDetector(
          onTap: () async {
            final id = item['_id']; // 👈 adjust if your id key is different

            await ref
                .read(appointmentControllerProvider.notifier)
                .fetchDetail(id, context);

            if (!mounted) return;

            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => AppointmentDetailSheet(),
            );
          },
          child: _appointmentCard(item, showCancel),
        );
      },
    );
  }

  Widget _appointmentCard(Map item, bool showCancel) {
    final date = DateTime.parse(item['appointmentDate']);
    final month = DateFormat.MMM().format(date); // shorter = cleaner
    final day = date.day;
    final weekday = DateFormat.E().format(date);

    final time = item['slotTime'];
    final service = item['service']?['title'] ?? '';
    final jewellery = item['jewelleryType'] ?? '';

    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors:
                  (item['status'] ?? '').toString().toLowerCase() ==
                      "report_ready"
                  ? [Colors.white, const Color(0xFFFFF8E1)] // subtle gold tint
                  : [Colors.white, Colors.white],
            ),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color:
                  (item['status'] ?? '').toString().toLowerCase() ==
                      "report_ready"
                  ? Colors.amber.withValues(alpha: 0.4)
                  : Colors.transparent,
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 14,
                offset: const Offset(0, 6),
                color: Colors.black.withValues(alpha: 0.05),
              ),
              if ((item['status'] ?? '').toString().toLowerCase() ==
                  "report_ready")
                BoxShadow(
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                  color: Colors.amber.withValues(alpha: 0.15),
                ),
            ],
          ),
          child: Row(
            children: [
              // 🔥 LEFT DATE BLOCK
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 14,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.primary.withValues(alpha: 0.15),
                      Colors.primary.withValues(alpha: 0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      month.toUpperCase(),
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                    Text(
                      "$day",
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      weekday,
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Timing",
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                        const Spacer(),

                        // 🔥 subtle status dot
                        if ((item['status'] ?? '').toString().toLowerCase() ==
                            "report_ready")
                          Container(
                            height: 8,
                            width: 8,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    Text(
                      time,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Divider(color: Colors.grey.withValues(alpha: 0.15)),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Expanded(child: _infoBlock("Service Type", service)),
                        Expanded(
                          child: _infoBlock("Jewellery Type", jewellery),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // 💎 PREMIUM REPORT BADGE
        if ((item['status'] ?? '').toString().toLowerCase() == "report_ready")
          Positioned(
            top: 8,
            right: 8,
            child: TweenAnimationBuilder(
              tween: Tween(begin: 0.8, end: 1.0),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOut,
              builder: (context, value, child) {
                return Transform.scale(scale: value as double, child: child);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.amber.shade400, Colors.orange.shade600],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withValues(alpha: 0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Row(
                  children: [
                    Icon(Icons.verified, color: Colors.white, size: 14),
                    SizedBox(width: 4),
                    Text(
                      "REPORT READY",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _infoBlock(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class AppointmentDetailSheet extends ConsumerWidget {
  const AppointmentDetailSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(appointmentStoreProvider).appointmentDetail;

    if (detail == null) {
      return const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final service = detail['service'] ?? {};

    final image = service['imgUrl'] ?? '';
    final title = service['title'] ?? '';
    final status = (detail['status'] ?? '').toString().toLowerCase();

    final date = detail['appointmentDate'];
    final time = detail['slotTime'];

    final jewellery = detail['jewelleryType'] ?? '';
    final weight = detail['approxWeight'] ?? '';
    final description = detail['description'] ?? '';
    final appointmentId = detail['appointmentId'] ?? '';

    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
      tween: Tween(begin: 40.0, end: 0.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, value),
          child: Opacity(opacity: 1 - (value / 40), child: child),
        );
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🪟 HANDLE
              Center(
                child: Container(
                  height: 4,
                  width: 40,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              // 🖼 IMAGE + BADGE + ANIMATION
              Stack(
                children: [
                  TweenAnimationBuilder(
                    duration: const Duration(milliseconds: 500),
                    tween: Tween(begin: 1.1, end: 1.0),
                    curve: Curves.easeOut,
                    builder: (context, scale, child) {
                      return Transform.scale(
                        scale: scale as double,
                        child: child,
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.network(
                        image,
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // overlay
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.2),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),

                  // 💎 BADGE
                  if (status == "report_ready")
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.amber.shade400,
                              Colors.orange.shade600,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withValues(alpha: 0.4),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.verified, color: Colors.white, size: 14),
                            SizedBox(width: 6),
                            Text(
                              "REPORT READY",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 16),

              // TITLE + STATUS
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _statusColor(status).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      status.toUpperCase(),
                      style: TextStyle(
                        color: _statusColor(status),
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // DATE + TIME
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _miniInfo(Icons.calendar_today, date),
                  _miniInfo(Icons.access_time, time),
                ],
              ),

              const SizedBox(height: 16),

              // DETAILS
              Row(
                children: [
                  Expanded(child: _detail("Jewellery", jewellery)),
                  Expanded(child: _detail("Weight", weight)),
                ],
              ),

              const SizedBox(height: 16),

              // DESCRIPTION
              if (description.isNotEmpty) ...[
                const Text(
                  "Description",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
                const SizedBox(height: 16),
              ],

              // ID
              Text(
                "ID: $appointmentId",
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),

              const SizedBox(height: 20),

              // 💎 DOWNLOAD BUTTON (HAPTIC)
              if (status == "report_ready") ...[
                GestureDetector(
                  onTapDown: (_) => HapticFeedback.lightImpact(),
                  onTap: () async {
                    await ref
                        .read(appointmentControllerProvider.notifier)
                        .downloadReport(detail['_id'], context);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.amber.shade400, Colors.orange.shade600],
                      ),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withValues(alpha: 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.download_rounded, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          "Download Report",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // CLOSE BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Close"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _miniInfo(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey),
        const SizedBox(width: 6),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
        ),
      ],
    );
  }

  Widget _detail(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        ),
      ],
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case "approved":
        return Colors.green;
      case "pending":
        return Colors.orange;
      case "rejected":
        return Colors.red;
      case "cancelled":
        return Colors.grey;
      case "report_ready":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}

class _BlinkingReportBadge extends StatefulWidget {
  @override
  State<_BlinkingReportBadge> createState() => _BlinkingReportBadgeState();
}

class _BlinkingReportBadgeState extends State<_BlinkingReportBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween(begin: 0.4, end: 1.0).animate(_controller),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          "REPORT READY",
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
