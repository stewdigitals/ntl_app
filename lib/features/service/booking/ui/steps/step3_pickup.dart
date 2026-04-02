import 'package:flutter/material.dart';
import 'package:ntl_app/core/components/button.dart';
import 'package:ntl_app/core/components/input.dart';

class Step3Pickup extends StatefulWidget {
  final VoidCallback onNext;

  const Step3Pickup({super.key, required this.onNext});

  @override
  State<Step3Pickup> createState() => _Step3PickupState();
}

class _Step3PickupState extends State<Step3Pickup> {
  int selectedTab = 0;
  bool insuranceEnabled = true;

  final houseController = TextEditingController();
  final areaController = TextEditingController();
  final pincodeController = TextEditingController();
  final cityController = TextEditingController();

  @override
  void dispose() {
    houseController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            /// 🔽 SCROLLABLE CONTENT
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
                      "Step 3 of 4",
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                    const SizedBox(height: 8),

                    const Text(
                      "How should we receive your sample?",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// 🔹 TOGGLE
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          _tab("Doorstep Pickup", 0),
                          _tab("Direct Lab Drop-off", 1),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// 🔹 ADDRESS
                    Row(
                      children: const [
                        Icon(Icons.location_on_outlined, color: Colors.amber),
                        SizedBox(width: 6),
                        Text(
                          "Pickup Address",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    CustomInputField(
                      hint: "House / Flat / Block No.",
                      controller: houseController,
                    ),

                    CustomInputField(
                      hint: "Apartment / Road / Area",
                      controller: areaController,
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: CustomInputField(
                            hint: "Pincode",
                            controller: pincodeController,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomInputField(
                            hint: "City",
                            controller: cityController,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// 🔹 INSURANCE CARD
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.accent.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.accent.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.accent.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.shield_outlined,
                              color: Colors.accent,
                            ),
                          ),

                          const SizedBox(width: 10),

                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Secure Insurance",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  "Protect your sample during transit",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.icon,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Switch(
                            value: insuranceEnabled,
                            activeThumbColor: Colors.white,
                            activeTrackColor: Colors.red,
                            inactiveThumbColor: Colors.grey,
                            inactiveTrackColor: Colors.grey.shade300,
                            onChanged: (val) {
                              setState(() => insuranceEnabled = val);
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    Container(
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        children: [
                          Image.asset(
                            "assets/step3_map_img.png",
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),

                          /// 🖤 DARK OVERLAY
                          Positioned.fill(
                            child: Container(
                              color: Colors.black.withValues(
                                alpha: 0.2,
                              ), // tweak 0.3–0.5
                            ),
                          ),

                          /// 📍 CENTER PIN
                          Center(
                            child: Container(
                              height: 44,
                              width: 44,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.red.withValues(alpha: 0.5),
                                    blurRadius: 12,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.my_location,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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

  /// 🔹 TAB
  Widget _tab(String text, int index) {
    final isActive = selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isActive ? Colors.red : Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
