import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ntl_app/core/components/button.dart';
import 'package:ntl_app/core/components/input.dart';
import 'package:ntl_app/core/components/selectable_card.dart';
import 'package:ntl_app/features/service/booking/state/booking_provider.dart';

class Step2Details extends ConsumerStatefulWidget {
  final VoidCallback onNext;

  const Step2Details({super.key, required this.onNext});

  @override
  ConsumerState<Step2Details> createState() => _Step2DetailsState();
}

class _Step2DetailsState extends ConsumerState<Step2Details> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int currentPage = 0;
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  String? selectedService;

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Step 2 of 4",
                      style: TextStyle(color: Colors.primary, fontSize: 12),
                    ),

                    const Text(
                      "Schedule Your Purity Test",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      "Professional gold & silver assaying services",
                      style: TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 20),

                    _buildTitle("Personal Details", Icons.person_outline),
                    const SizedBox(height: 10),

                    CustomInputField(
                      label: "Full Name",
                      hint: "John Doe",
                      controller: nameController,
                    ),

                    CustomInputField(
                      label: "Phone Number",
                      hint: "+91 98765 XXXXX",
                      controller: phoneController,
                    ),

                    const SizedBox(height: 20),

                    _buildTitle("Select Service", Icons.category_outlined),
                    const SizedBox(height: 10),

                    SizedBox(
                      height: 180,
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() => currentPage = index);
                        },
                        children: [
                          _cardRow([
                            _serviceCard(
                              "Gold Assay",
                              "Fire/XRF purity testing",
                              Colors.amber.withValues(alpha: 0.1),
                              Colors.amber,
                              Icons.diamond,
                            ),
                            _serviceCard(
                              "Silver Assay",
                              "Chemical purity testing",
                              Colors.grey.withValues(alpha: 0.1),
                              Colors.grey,
                              Icons.layers,
                            ),
                          ]),
                          _cardRow([
                            _serviceCard(
                              "Refining",
                              "High purity refining",
                              Colors.red.withValues(alpha: 0.1),
                              Colors.red,
                              Icons.precision_manufacturing,
                            ),
                            _serviceCard(
                              "Hallmark",
                              "Certification service",
                              Colors.blue.withValues(alpha: 0.1),
                              Colors.blue,
                              Icons.verified,
                            ),
                          ]),
                          _cardRow([
                            _serviceCard(
                              "Platinum Test",
                              "Premium metal analysis",
                              Colors.purple.withValues(alpha: 0.1),
                              Colors.purple,
                              Icons.star,
                            ),
                            _serviceCard(
                              "Diamond Test",
                              "Authenticity check",
                              Colors.teal.withValues(alpha: 0.1),
                              Colors.teal,
                              Icons.blur_on,
                            ),
                          ]),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) {
                        final isActive = currentPage == index;

                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.easeOutCubic,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 12,
                          ),

                          width: isActive ? 20 : 6,
                          height: 6,

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),

                            // 🔥 Gradient for active
                            gradient: isActive
                                ? const LinearGradient(
                                    colors: [Colors.primary, Color(0xFFFF6F61)],
                                  )
                                : null,

                            color: isActive ? null : Colors.grey.shade300,

                            // ✨ Soft glow
                            boxShadow: isActive
                                ? [
                                    BoxShadow(
                                      color: Colors.primary.withValues(
                                        alpha: 0.4,
                                      ),
                                      blurRadius: 8,
                                      spreadRadius: 1,
                                    ),
                                  ]
                                : [],
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 20),
                    _buildTitle(
                      "Preffered Schedule",
                      Icons.calendar_month_outlined,
                    ),
                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Expanded(
                          child: CustomInputField(
                            label: "Date",
                            hint: "Select Date",
                            controller: dateController,
                            readOnly: true,
                            onTap: () => _selectDate(context),

                            // ✨ Premium icon
                            suffix: const Icon(Icons.calendar_today, size: 18),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomInputField(
                            label: "Time",
                            hint: "Select Time",
                            readOnly: true,
                            controller: timeController,
                            onTap: () => _selectTime(context),

                            // ✨ Premium icon
                            suffix: const Icon(Icons.access_time, size: 18),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    _buildTitle("Lab Location", Icons.location_on_outlined),
                    MapPreviewCard(
                      title: "Main Branch - Banjara Hills",
                      subtitle: "Suite 204, Jewel Plaza, Road No. 12",
                      onTap: () {
                        // open map
                      },
                    ),
                    SizedBox(height: 20),
                    TrustBadges(),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: CustomElevatedButton(
                text: "Continue",
                onPressed: widget.onNext,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),

      // ✨ PREMIUM THEME
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.red, // header + selected
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      dateController.text =
          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),

      // ✨ PREMIUM THEME
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.red,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      final hour = pickedTime.hourOfPeriod == 0 ? 12 : pickedTime.hourOfPeriod;
      final minute = pickedTime.minute.toString().padLeft(2, '0');
      final period = pickedTime.period == DayPeriod.am ? "AM" : "PM";

      timeController.text = "$hour:$minute $period";
    }
  }

  Widget _cardRow(List<Widget> cards) {
    return Row(
      children: cards.map((card) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: card,
          ),
        );
      }).toList(),
    );
  }

  /// 🔹 SERVICE CARD (NOW WORKS 🔥)
  Widget _serviceCard(
    String title,
    String subtitle,
    Color iconBg,
    Color iconColor,
    IconData icon,
  ) {
    return SelectableCard(
      title: title,
      subtitle: subtitle,
      icon: icon,
      iconColor: iconColor,
      iconBg: iconBg,
      layout: CardLayoutType.vertical,
      isSelected: selectedService == title,
      onTap: () {
        setState(() {
          selectedService = title;
        });

        ref.read(bookingProvider.notifier).setService(title);
      },
    );
  }
}

Widget _buildTitle(String title, IconData icon) {
  return Row(
    children: [
      Icon(icon, color: Colors.accent, size: 25),
      SizedBox(width: 5),
      Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w900,
          color: Colors.black,
        ),
      ),
    ],
  );
}

class MapPreviewCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final String imagePath;

  const MapPreviewCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.imagePath = "assets/step2_map_img.png",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 140,
                  width: double.infinity,
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.matrix([
                      0.2126,
                      0.7152,
                      0.0722,
                      0,
                      0,
                      0.2126,
                      0.7152,
                      0.0722,
                      0,
                      0,
                      0.2126,
                      0.7152,
                      0.0722,
                      0,
                      0,
                      0,
                      0,
                      0,
                      1,
                      0,
                    ]),
                    child: Opacity(
                      opacity: 0.6, // 👈 faded look
                      child: Image.asset(imagePath, fit: BoxFit.cover),
                    ),
                  ),
                ),

                /// 🌫 WHITE FADE OVERLAY (TOP → BOTTOM)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withValues(alpha: 0.7),
                          Colors.white.withValues(alpha: 0.2),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                /// 📍 VIEW MAP BUTTON (SOFT STYLE)
                Positioned(
                  left: 12,
                  bottom: 10,
                  child: GestureDetector(
                    onTap: onTap,
                    child: Row(
                      children: const [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.black54,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "View on Maps",
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            /// 📄 DETAILS SECTION
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TrustBadges extends StatelessWidget {
  const TrustBadges({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.symmetric(
          horizontal: BorderSide(color: Colors.grey.shade400, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          _BadgeItem(icon: Icons.verified_outlined, label: "GOVT. CERTIFIED"),
          _BadgeItem(
            icon: Icons.workspace_premium_outlined,
            label: "NABL ACCREDITED",
          ),
          _BadgeItem(icon: Icons.shield_outlined, label: "100% SECURE"),
        ],
      ),
    );
  }
}

class _BadgeItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _BadgeItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// 🟡 ICON CIRCLE
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: Colors.accent.withValues(alpha: 0.10),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.accent, size: 22),
        ),

        const SizedBox(height: 8),

        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.icon,
          ),
        ),
      ],
    );
  }
}
