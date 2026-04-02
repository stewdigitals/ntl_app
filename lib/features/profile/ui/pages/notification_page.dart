import 'package:flutter/material.dart';
import 'package:ntl_app/core/components/custom_topbar.dart';
import 'package:ntl_app/core/layout/layout.dart';
import 'package:ntl_app/features/profile/store/profile.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      onTabChange: (index) {},
      currentIndex: 4,
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            CustomTopAppBar(
              title: "Notifications",
              showBack: true,
              showRightBg: true,
              rightIcon: Icons.done,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: NotificationTabs(
                selectedIndex: selectedTab,
                onTap: (i) => setState(() => selectedTab = i),
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const NotificationSectionTitle("TODAY"),

                    NotificationCard(
                      item: NotificationItem(
                        title: "Report Ready",
                        description:
                            "Your Hallmark purity report for Order #NTL-8821 is now available for download.",
                        time: "2h ago",
                        icon: Icons.description,
                        iconBg: Colors.amber.shade100,
                        iconColor: Colors.amber.shade800,
                      ),
                    ),

                    NotificationCard(
                      item: NotificationItem(
                        title: "Live Gold Rate Update",
                        description:
                            "Morning session alert: 24K Gold is trading at ₹6,245/gm. Up by 0.4% today.",
                        time: "4h ago",
                        icon: Icons.show_chart,
                        iconBg: Colors.orange.shade100,
                        iconColor: Colors.orange,
                      ),
                    ),

                    const NotificationSectionTitle("YESTERDAY"),

                    NotificationCard(
                      item: NotificationItem(
                        title: "Appointment Confirmed",
                        description:
                            "Your melting & testing slot for tomorrow at 11:30 AM has been confirmed.",
                        time: "Yesterday",
                        icon: Icons.event,
                        iconBg: Colors.red.shade100,
                        iconColor: Colors.red,
                      ),
                    ),

                    NotificationCard(
                      item: NotificationItem(
                        title: "Price Drop Alert",
                        description:
                            "Gold prices hit your target of ₹6,150/gm.",
                        time: "Yesterday",
                        icon: Icons.notifications,
                        iconBg: Colors.amber.shade100,
                        iconColor: Colors.amber,
                      ),
                    ),
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

class NotificationCard extends StatelessWidget {
  final NotificationItem item;

  const NotificationCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ICON
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: item.iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(item.icon, color: item.iconColor),
          ),

          const SizedBox(width: 12),

          // TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Text(
                      item.time,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                Text(
                  item.description,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationSectionTitle extends StatelessWidget {
  final String title;

  const NotificationSectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: Colors.orange,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

class NotificationTabs extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const NotificationTabs({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = ["All", "Reports", "Rates"];

    return Row(
      children: List.generate(tabs.length, (index) {
        final isActive = selectedIndex == index;

        return GestureDetector(
          onTap: () => onTap(index),
          child: Container(
            margin: const EdgeInsets.only(right: 20),
            padding: const EdgeInsets.only(bottom: 6),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isActive ? Colors.orange : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
            child: Text(
              tabs[index],
              style: TextStyle(
                color: isActive ? Colors.orange : Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }),
    );
  }
}
