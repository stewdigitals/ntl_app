import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ntl_app/core/components/custom_topbar.dart';

class ReusablePage extends StatelessWidget {
  final String title;
  final String heading;
  final Widget subHeading;
  final Widget body;
  final bool showShare;
  final String? middleText;

  const ReusablePage({
    super.key,
    required this.title,
    required this.heading,
    required this.subHeading,
    required this.body,
    this.showShare = true,
    this.middleText,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f6f6),

      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Transform.translate(
              offset: const Offset(0, -12),
              child: CustomTopAppBar(
                title: title,
                showBack: true,
                showRightIcon: showShare,
                rightIcon: Icons.share_outlined,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      heading.toUpperCase(),
                      style: GoogleFonts.spaceGrotesk(
                        color: Colors.primary,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.2,
                      ),
                    ),

                    const SizedBox(height: 10),

                    DefaultTextStyle(
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 15,
                        color: Colors.icon,
                        height: 1.5,
                      ),
                      child: subHeading,
                    ),

                    body,
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

class AboutSectionTile extends StatelessWidget {
  final int index;
  final String title;
  final Widget description;

  const AboutSectionTile({
    super.key,
    required this.index,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 26,
            width: 26,
            decoration: const BoxDecoration(
              color: Color(0xfff3d8cb),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              "$index",
              style: GoogleFonts.spaceGrotesk(
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 4),

                description,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
