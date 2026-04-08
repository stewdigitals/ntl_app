import 'package:flutter/material.dart';
import 'package:ntl_app/core/components/button.dart';
import 'package:ntl_app/core/components/custom_topbar.dart';
import 'package:ntl_app/core/components/video_provider.dart';

class ServiceDetailsPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final String tags;
  final String description;
  final String? videoUrl;
  final String buttonText;
  final VoidCallback onButtonTap;

  const ServiceDetailsPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.tags,
    required this.description,
    this.videoUrl,
    required this.buttonText,
    required this.onButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 🔝 TOP BAR
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 12,
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
                  // 🎬 HERO
                  Stack(
                    children: [
                      Image.network(
                        image,
                        height: 260,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),

                      Container(
                        height: 260,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withValues(alpha: 0.1),
                              Colors.black.withValues(alpha: 0.85),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 20,
                        left: 16,
                        right: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 6),

                            Text(
                              subtitle,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: tags.split(',').map((tag) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.3),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.white.withValues(
                                        alpha: 0.5,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    tag.trim(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
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
                    child: Container(
                      padding: const EdgeInsets.all(16),
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
                      child: Text(
                        description,
                        style: const TextStyle(
                          height: 1.6,
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),

                  // 🎥 VIDEO SECTION
                  if (videoUrl != null && videoUrl!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Watch Service",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 10),

                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: UniversalVideoPlayer(url: videoUrl!),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // 🔴 BUTTON
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: CustomElevatedButton(
              text: buttonText,
              onPressed: () async {
                onButtonTap();
              },
            ),
          ),
        ],
      ),
    );
  }
}
