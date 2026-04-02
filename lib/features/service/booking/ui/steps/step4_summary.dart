import 'package:flutter/material.dart';
import 'package:ntl_app/core/components/button.dart';

class Step4Summary extends StatelessWidget {
  const Step4Summary({super.key});

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
                    /// 🔹 STEP TITLE
                    const Text(
                      "Step 4 of 4",
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                    const SizedBox(height: 8),

                    const Text(
                      "Confirm Your Booking",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// 🔹 LAB CARD
                    _labCard(),

                    const SizedBox(height: 20),

                    /// 🔹 SECTION TITLE
                    const Text(
                      "Booking Summary",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// 🔹 SUMMARY ITEMS
                    _summaryItem(
                      icon: Icons.science_outlined,
                      title: "SELECTED SERVICE",
                      value: "Full Executive Health Checkup",
                      color: Colors.primary,
                    ),

                    _summaryItem(
                      icon: Icons.calendar_today_outlined,
                      title: "DATE & TIME",
                      value: "Monday, Oct 24 · 09:30 AM",
                      color: Colors.accent,
                    ),

                    _summaryItem(
                      icon: Icons.location_on_outlined,
                      title: "LAB LOCATION",
                      value:
                          "Main Branch, Jubilee Hills\nRoad No. 36, Hyderabad",
                      color: Colors.icon,
                    ),

                    const SizedBox(height: 16),

                    /// 🔹 BILL CARD
                    _billCard(),

                    const SizedBox(height: 16),

                    /// 🔹 TERMS
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "By clicking \"Pay & Confirm\", you agree to our Terms of Service and Privacy Policy. Cancellation is free up to 24 hours before the appointment.",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.icon,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: CustomElevatedButton(
                text: "Pay & Confirm Booking",
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _labCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nagesh Touch Lab",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.verified_outlined,
                      color: Colors.accent,
                      size: 16,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Premium Diagnostic Service",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.icon,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              "assets/step4_lab_img.jpg",
              height: 90,
              width: 90,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryItem({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade100),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _billCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          _billRow("Subtotal", "₹4,500.00"),
          const SizedBox(height: 6),
          _billRow("Home Sample Collection", "FREE", highlight: true),

          const Divider(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Amount",
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                  ),
                  Text(
                    "Inclusive of all taxes",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.icon,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Text(
                "₹4,500.00",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _billRow(String title, String value, {bool highlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Colors.icon)),
        Text(
          value,
          style: TextStyle(
            color: highlight ? Colors.accent : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
