import 'package:flutter/material.dart';
import 'package:ntl_app/core/components/custom_topbar.dart';
import 'package:ntl_app/core/components/horizontal_card.dart';
import 'package:ntl_app/core/layout/layout.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      currentIndex: 4,
      onTabChange: (index) {},

      child: Column(
        children: [
          CustomTopAppBar(
            title: "Profile",
            showBack: false,
            showRightIcon: true,
            rightIcon: Icons.settings,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileHeaderCard(
                    name: "Nagesh Touch Lab",
                    imageUrl:
                        "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80",
                    isGoldMember: true,
                    isVerified: true,
                    onEditTap: () {
                      debugPrint("Edit clicked");
                    },
                  ),
                  const SizedBox(height: 20),

                  const StatsRow(),

                  const SizedBox(height: 20),

                  const SectionTitle("LABORATORY MANAGEMENT"),

                  const SizedBox(height: 10),

                  MenuList(
                    items: [
                      MenuItemData(
                        "My Reports",
                        "Access all testing certificates",
                        Icons.description,
                        Colors.primary,
                      ),
                      MenuItemData(
                        "Booking History",
                        "Manage your testing appointments",
                        Icons.calendar_today,
                        Colors.accent,
                      ),
                      MenuItemData(
                        "Manage Business Details",
                        "Store location, hours, and branding",
                        Icons.store,
                        Colors.icon,
                      ),
                      MenuItemData(
                        "Address Book",
                        "Saved pickup and delivery locations",
                        Icons.location_on,
                        Colors.icon,
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  const SectionTitle("ACCOUNT SETTINGS"),

                  const SizedBox(height: 10),

                  MenuList(
                    items: [
                      MenuItemData(
                        "Security",
                        "",
                        Icons.shield_outlined,
                        Colors.grey,
                      ),
                      MenuItemData(
                        "Notifications",
                        "2 NEW",
                        Icons.notifications,
                        Colors.grey,
                      ),
                      MenuItemData(
                        "Language",
                        "English (US)",
                        Icons.language,
                        Colors.grey,
                      ),
                    ],
                  ),
                  const SignOutButton(),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StatsRow extends StatelessWidget {
  const StatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: _StatCard("TOTAL REPORTS", "1,284")),
        SizedBox(width: 10),
        Expanded(child: _StatCard("TRUST SCORE", "9.8/10", highlight: true)),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final bool highlight;

  const _StatCard(this.title, this.value, {this.highlight = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.icon,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: highlight ? Colors.accent : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 11,
        letterSpacing: 1,
        color: Colors.grey,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class MenuItemData {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconBg;

  MenuItemData(this.title, this.subtitle, this.icon, this.iconBg);
}

class MenuList extends StatelessWidget {
  final List<MenuItemData> items;

  const MenuList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((e) {
        return HorizontalCard(
          title: e.title,
          subtitle: e.subtitle,
          icon: e.icon,

          // 🎨 Styling (you can tweak globally here)
          iconColor: e.iconBg,
          iconBg: e.iconBg.withValues(alpha: 0.1),

          // 👉 Optional behavior
          onTap: () {
            debugPrint("${e.title} clicked");
          },

          showIconShadow: false,

          showArrow: true,
        );
      }).toList(),
    );
  }
}

class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      icon: const Icon(
        Icons.logout,
        color: Colors.primary,
        fontWeight: FontWeight.w900,
      ),
      label: const Text(
        "Sign Out",
        style: TextStyle(
          color: Colors.primary,
          fontSize: 16,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class ProfileHeaderCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final bool isGoldMember;
  final bool isVerified;
  final VoidCallback? onEditTap;

  const ProfileHeaderCard({
    super.key,
    required this.name,
    required this.imageUrl,
    this.isGoldMember = false,
    this.isVerified = false,
    this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(imageUrl),
              ),
            ),

            Positioned(
              bottom: 8,
              right: 10,
              child: GestureDetector(
                onTap: onEditTap,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.primary,
                    border: Border.all(color: Colors.white, width: 3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.verified_outlined,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Name
        Text(
          name,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 10),

        // Badges
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isGoldMember)
              _badge(
                "GOLD MEMBER",
                Colors.accent.withValues(alpha: 0.05),
                Colors.accent,
              ),
            if (isGoldMember && isVerified) const SizedBox(width: 8),
            if (isVerified)
              _badge(
                "VERIFIED JEWELLER",
                Colors.primary.withValues(alpha: 0.05),
                Colors.primary,
              ),
          ],
        ),
      ],
    );
  }

  Widget _badge(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}
