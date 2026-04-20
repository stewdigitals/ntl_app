// PROFILE PAGE (PREMIUM)

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ntl_app/core/components/custom_topbar.dart';
import 'package:ntl_app/core/components/horizontal_card.dart';
import 'package:ntl_app/core/layout/layout.dart';
import 'package:ntl_app/features/auth/signup/provider/signup_provider.dart';
import 'package:ntl_app/features/auth/signup/store/signup.dart';
import 'package:ntl_app/features/profile/store/profile.dart';
import 'package:ntl_app/features/profile/ui/pages/faqs.dart';
import 'package:ntl_app/features/profile/ui/pages/privacy_policy.dart';
import 'package:ntl_app/features/profile/ui/pages/support_page.dart';
import 'package:ntl_app/features/profile/ui/pages/terms_and_conditions.dart';
import 'package:ntl_app/features/service/booking/provider/booking_provider.dart';
import 'package:ntl_app/features/service/booking/store/booking.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  ProfileModel? user;

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final profile = await ref.read(authProvider).fetchProfile();
      setState(() => user = profile);

      await ref
          .read(appointmentControllerProvider.notifier)
          .fetchAppointments();
    });
  }

  @override
  Widget build(BuildContext context) {
    final store = ref.watch(appointmentStoreProvider);
    final appointments = store.appointments;

    final total = appointments.length;
    final cancelled = appointments
        .where((a) => a['status'] == 'cancelled')
        .length;
    final upcoming = appointments
        .where((a) => a['status'] == 'scheduled')
        .length;

    return AppLayout(
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
                children: [
                  /// 👤 PROFILE CARD
                  ProfileHeaderCard(
                    name: user?.name ?? "User",
                    imageUrl: "https://i.pravatar.cc/300",
                    isGoldMember: true,
                    isVerified: user?.verified ?? false,
                  ),

                  const SizedBox(height: 20),

                  /// 📊 PREMIUM STATS
                  Row(
                    children: [
                      Expanded(child: _stat("TOTAL", total.toString())),
                      const SizedBox(width: 10),
                      Expanded(child: _stat("UPCOMING", upcoming.toString())),
                      const SizedBox(width: 10),
                      Expanded(child: _stat("CANCELLED", cancelled.toString())),
                    ],
                  ),

                  const SizedBox(height: 24),

                  sectionTitle("ACCOUNT"),
                  SizedBox(height: 10),

                  MenuList(
                    items: [
                      MenuItemData(
                        "Booking History",
                        "",
                        Icons.calendar_today,
                        Colors.primary,
                        () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const MainScreen(initialIndex: 2),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  sectionTitle("ABOUT"),
                  SizedBox(height: 10),

                  HorizontalCard(
                    title: "FAQs",
                    subtitle: "Frequently Asked Questions",
                    icon: Icons.question_mark,
                    iconBg: Colors.primary.withValues(alpha: 0.1),
                    iconColor: Colors.primary,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FaqsPage()),
                      );
                    },
                    showIconShadow: false,
                    showBorder: false,
                  ),

                  HorizontalCard(
                    title: "Terms & Conditions",
                    subtitle: "Read our terms and conditions",
                    icon: Icons.document_scanner,
                    iconBg: Colors.primary.withValues(alpha: 0.1),
                    iconColor: Colors.primary,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TermsAndConditionsPage(),
                        ),
                      );
                    },
                    showIconShadow: false,
                    showBorder: false,
                  ),

                  HorizontalCard(
                    title: "Privacy Policy",
                    subtitle: "Read our privacy policy",
                    icon: Icons.privacy_tip,
                    iconBg: Colors.primary.withValues(alpha: 0.1),
                    iconColor: Colors.primary,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrivacyPolicyPage(),
                        ),
                      );
                    },
                    showIconShadow: false,
                    showBorder: false,
                  ),

                  HorizontalCard(
                    title: "Support",
                    subtitle: "Contact us for help",
                    icon: Icons.support_agent,
                    iconBg: Colors.primary.withValues(alpha: 0.1),
                    iconColor: Colors.primary,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SupportPage()),
                      );
                    },
                    showIconShadow: false,
                    showBorder: false,
                  ),

                  const SignOutButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stat(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Colors.secondary, Colors.icon]),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        color: Colors.grey,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class ProfileHeaderCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final bool isGoldMember;
  final bool isVerified;

  const ProfileHeaderCard({
    super.key,
    required this.name,
    required this.imageUrl,
    this.isGoldMember = false,
    this.isVerified = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff0f172a), Color(0xff1e293b), Color(0xff334155)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .10),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          /// Premium Icon Avatar ✨
          Container(
            height: 92,
            width: 92,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xffffd66b), Color(0xffffb800)],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.amber.withValues(alpha: .35),
                  blurRadius: 18,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Container(
              margin: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: const Icon(
                Icons.person_rounded,
                size: 48,
                color: Color(0xff0f172a),
              ),
            ),
          ),

          const SizedBox(height: 14),

          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 8),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              if (isVerified)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: .15),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.verified_rounded,
                        color: Colors.greenAccent,
                        size: 16,
                      ),
                      SizedBox(width: 6),
                      Text(
                        "Verified",
                        style: TextStyle(
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class MenuList extends StatelessWidget {
  final List<MenuItemData> items;

  const MenuList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((e) {
        return GestureDetector(
          onTap: e.onTap,
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: e.iconBg.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(e.icon, color: e.iconBg),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    e.title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 14),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class SignOutButton extends ConsumerWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton.icon(
      onPressed: () async {
        await ref.read(authProvider).logout(context);
      },
      icon: const Icon(Icons.logout, color: Colors.red),
      label: const Text(
        "Sign Out",
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
      ),
    );
  }
}
