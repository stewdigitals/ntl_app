import 'package:flutter/material.dart';
import 'package:ntl_app/core/components/button.dart';
import 'package:ntl_app/core/components/custom_topbar.dart';
import 'package:ntl_app/core/components/horizontal_card.dart';
import 'package:ntl_app/features/service/store/service.dart';

class ServiceDetailsPage extends StatelessWidget {
  final String title;
  final String image;
  final List<TagItem> tags;
  final String description;
  final List<BenefitItem> benefits;
  final List<StepItem> steps;
  final List<AnalysisItem> analysis;
  final String buttonText;
  final VoidCallback onButtonTap;

  const ServiceDetailsPage({
    super.key,
    required this.title,
    required this.image,
    required this.tags,
    required this.description,
    required this.benefits,
    required this.steps,
    required this.analysis,
    required this.buttonText,
    required this.onButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 12,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: CustomTopAppBar(
              title: title,
              showBack: true,
              showRightIcon: true,
              rightIcon: Icons.share,
              onBack: () => Navigator.pop(context),
              onRightTap: () {},
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        image,
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),

                      Container(
                        height: 250,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.8),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 16,
                        left: 16,
                        right: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Wrap(
                              spacing: 8,
                              children: tags.map((tag) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: tag.borderColor,
                                      width: 1,
                                    ),
                                    color: tag.color,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    tag.text,
                                    style: TextStyle(
                                      color: tag.textColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // 📄 DESCRIPTION
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      description,
                      style: const TextStyle(height: 1.6, fontSize: 17),
                    ),
                  ),

                  SizedBox(height: 10),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Core Benefits",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  ...benefits.map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: HorizontalCard(
                        title: e.title,
                        subtitle: e.desc,
                        icon: e.icon,
                        iconColor: Colors.amber,
                        iconBg: const Color(0xFFF5EFE4),
                        showCardShadow: true,
                        showIconShadow: false,
                        showArrow: false,
                        showBorder: false,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 🔢 STEPS
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "How it Works",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  ...List.generate(steps.length, (i) {
                    final s = steps[i];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.primary,
                            child: Text(
                              "0${i + 1}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  s.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  s.desc,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),

                  const SizedBox(height: 20),

                  // 📊 ANALYSIS
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F172A),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 🔶 HEADER
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Spectral Analysis Output",
                                        style: TextStyle(
                                          color: Colors.accent,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "Real-time elemental distribution",
                                        style: TextStyle(
                                          color: Colors.icon,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.bar_chart,
                                    color: Color(0xFFEAB308),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 30),

                              // 📊 DATA LIST
                              ...analysis.map((e) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          e.name,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        Text(
                                          "${e.value}%",
                                          style: TextStyle(
                                            color: e.color,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 10),

                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: LinearProgressIndicator(
                                        value: e.value / 100,
                                        minHeight: 12,
                                        borderRadius: BorderRadius.circular(10),
                                        color: e.color,
                                        backgroundColor: Colors.white12,
                                      ),
                                    ),

                                    const SizedBox(height: 16),
                                  ],
                                );
                              }),

                              const SizedBox(height: 15),

                              Container(height: 1, color: Colors.white12),

                              const SizedBox(height: 15),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Analyzer SN: XRF-9921-BT",
                              style: TextStyle(
                                color: Colors.white38,
                                fontSize: 11,
                              ),
                            ),
                            Text(
                              "Confidence Level: High",
                              style: TextStyle(
                                color: Colors.white38,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 🔴 BUTTON
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: CustomElevatedButton(
              text: buttonText,
              onPressed: onButtonTap,
            ),
          ),
        ],
      ),
    );
  }
}
