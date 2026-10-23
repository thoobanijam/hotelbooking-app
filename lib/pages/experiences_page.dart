
import 'package:flutter/material.dart';
import 'package:hotelbooking_application_1/pages/appfooter.dart';
import 'package:hotelbooking_application_1/pages/experience_header.dart';
class ExperiencesPage extends StatelessWidget {
  const ExperiencesPage({super.key});

  static const Color navy = Color(0xFF0F1B2D);
  static const Color gold = Color(0xFFD4AF37);

  final List<Map<String, String>> experiences = const [
    {
      'image': 'assets/img/backwater.jpg',
      'title': 'Backwater Cruise',
      'description':
          'Enjoy a peaceful cruise through beautiful backwaters, '
          'surrounded by nature and breathtaking scenery.',
      'button': 'Explore Experience',
    },
    {
      'image': 'assets/img/champinge.webp',
      'title': 'Luxury Camping',
      'description':
          'Experience the perfect combination of outdoor adventure, '
          'comfort, and luxury under the stars.',
      'button': 'Discover Stay',
    },
    {
      'image': 'assets/img/ridewavejpeg.jpeg',
      'title': 'Ocean Wave Adventure',
      'description':
          'Feel the excitement of the ocean and discover '
          'unforgettable adventures on the water.',
      'button': 'Book Adventure',
    },
    {
      'image': 'assets/img/watchtower.jpg',
      'title': 'Scenic Watchtower',
      'description':
          'Discover spectacular panoramic views and capture '
          'beautiful memories from above.',
      'button': 'View Experience',
    },
    {
      'image': 'assets/img/sundownerset.webp',
      'title': 'Sunset Sundowners',
      'description':
          'Relax with refreshing drinks and peaceful sunset views '
          'in an unforgettable setting.',
      'button': 'Discover More',
    },
    {
      'image': 'assets/img/mangroves.webp',
      'title': 'Mangrove Exploration',
      'description':
          'Explore fascinating mangrove forests and discover '
          'the beauty of nature and wildlife.',
      'button': 'Explore Nature',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F3),
      appBar: AppBar(
        title: const Text(
          'Experiences',
          style: TextStyle(
            fontFamily: 'Georgia',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: navy,
        foregroundColor: gold,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Memorable Experiences',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: 'Georgia',
              color: navy,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Discover extraordinary moments and make '
            'every stay unforgettable.',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black54,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 24),

          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 700;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: experiences.length,
                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isWide ? 2 : 1,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  mainAxisExtent: 390,
                ),
                itemBuilder: (context, index) {
                  final experience = experiences[index];

                  return experienceCard(
                    context,
                    experience,
                  );
                },
              );
            },
          ),

          const SizedBox(height: 30),
          const ExperienceHeader(),
          const SizedBox(height: 30),
          const AppFooter(),
        ],
      ),
    );
  }

  Widget experienceCard(
    BuildContext context,
    Map<String, String> experience,
  ) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black12,
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 210,
            width: double.infinity,
            child: Image.asset(
              experience['image']!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(0xFFEAE6DC),
                  alignment: Alignment.center,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image_not_supported_outlined,
                        size: 42,
                        color: navy,
                      ),
                      SizedBox(height: 8),
                      Text('Image not found'),
                    ],
                  ),
                );
              },
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    experience['title']!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: navy,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Expanded(
                    child: Text(
                      experience['description']!,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: Colors.black54,
                      ),
                    ),
                  ),

                  Center(
                    child: SizedBox(
                      width: 350,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: navy,
                          foregroundColor: gold,
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${experience['title']} selected',
                              ),
                            ),
                          );
                        },
                        child: Text(
                          experience['button']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
