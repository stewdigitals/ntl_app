import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ntl_app/core/components/button.dart';
import 'package:ntl_app/core/components/horizontal_card.dart';
import 'package:ntl_app/core/components/selectable_card.dart';
import 'package:ntl_app/features/service/booking/state/booking_provider.dart';

class Step1BranchService extends ConsumerStatefulWidget {
  final VoidCallback onNext;

  const Step1BranchService({super.key, required this.onNext});

  @override
  ConsumerState<Step1BranchService> createState() => _Step1BranchServiceState();
}

class _Step1BranchServiceState extends ConsumerState<Step1BranchService> {
  String? selectedBranch;
  String? selectedService;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Step 1 of 4",
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                  const SizedBox(height: 8),

                  const Text(
                    "Welcome",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    "Please select your preferred branch and the service you require for assaying.",
                    style: TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "SELECT LAB BRANCH",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 10),

                  _branchCard(
                    title: "Main Gold Souk Branch",
                    subtitle: "Deira, Dubai - Central Laboratory",
                  ),
                  _branchCard(
                    title: "JLT Tech Center",
                    subtitle: "Cluster F, DMCC Freezone",
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Icon(
                        Icons.science_outlined,
                        color: Colors.grey,
                        size: 18,
                      ),
                      SizedBox(width: 5),
                      const Text(
                        "PRIMARY SERVICE",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  _serviceCard(
                    "Gold Assay",
                    "Fire assay or XRF purity testing",
                    Colors.amber.withValues(alpha: 0.10),
                    Colors.amber,
                    Icons.diamond,
                  ),
                  _serviceCard(
                    "Silver Assay",
                    "Chemical analysis for silver purity",
                    Color(0xFFF1F5F9),
                    Colors.grey,
                    Icons.layers,
                  ),
                  _serviceCard(
                    "Bullion Refining",
                    "High-purity refining services",
                    Colors.red.withValues(alpha: 0.10),
                    Colors.red,
                    Icons.precision_manufacturing,
                  ),

                  MapPreviewCard(onTap: () {}),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // 🔴 FIXED BUTTON
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomElevatedButton(
              text: "Continue →",
              onPressed: (selectedBranch != null) ? widget.onNext : () {},
            ),
          ),
        ],
      ),
    );
  }

  // 🏢 BRANCH CARD
  Widget _branchCard({required String title, required String subtitle}) {
    return SelectableCard(
      title: title,
      subtitle: subtitle,
      icon: Icons.location_on,
      isSelected: selectedBranch == title,
      onTap: () {
        setState(() => selectedBranch = title);
      },
    );
  }

  // 🧪 SERVICE CARD
  Widget _serviceCard(
    String title,
    String subtitle,
    Color iconBg,
    Color iconColor,
    IconData icon,
  ) {
    return HorizontalCard(
      title: title,
      subtitle: subtitle,
      icon: icon,
      iconColor: iconColor,
      iconBg: iconBg,
      showArrow: true,
      borderColor: Colors.grey.shade300,
      showIconShadow: false,

      onTap: () {
        setState(() {
          selectedService = title;
        });

        ref.read(bookingProvider.notifier).setService(title);
      },
    );
  }
}

class MapPreviewCard extends StatelessWidget {
  final VoidCallback onTap;

  const MapPreviewCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 🗺 MAP IMAGE
            Positioned.fill(
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
                child: Image.asset(
                  "assets/map_placeholder.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // 🔘 BUTTON
            Positioned(
              bottom: 60,
              child: GestureDetector(
                onTap: onTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.red, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.location_on, color: Colors.red, size: 18),
                      SizedBox(width: 6),
                      Text(
                        "View Branch on Map",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
