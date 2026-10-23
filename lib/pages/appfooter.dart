
import 'package:flutter/material.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  static const Color navy = Color(0xFF0F1B2D);
  static const Color gold = Color(0xFFD4AF37);
  static const Color lightGold = Color(0xFFEBBA50);
  static const Color textColor = Color(0xFFE5E1D8);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isMobile = width < 600;
        final isTablet = width >= 600 && width < 1000;

        final columnCount = isMobile ? 1 : (isTablet ? 2 : 4);

        return Container(
          width: double.infinity,
          color: navy,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Gold line at the top
              Container(
                height: 3,
                color: gold,
              ),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 24 : 40,
                  vertical: 35,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Footer content columns
                    Wrap(
                      spacing: 35,
                      runSpacing: 30,
                      children: [
                        SizedBox(
                          width: isMobile
                              ? width - 48
                              : (width - 115) / columnCount,
                          child: _buildBrand(),
                        ),

                        SizedBox(
                          width: isMobile
                              ? width - 48
                              : (width - 115) / columnCount,
                          child: _buildLinkSection(
                            'QUICK LINKS',
                            [
                              'Home',
                              'Destinations',
                              'Hotels',
                              'Experiences',
                              'Latest Offers',
                            ],
                          ),
                        ),

                        SizedBox(
                          width: isMobile
                              ? width - 48
                              : (width - 115) / columnCount,
                          child: _buildLinkSection(
                            'GUEST SERVICES',
                            [
                              'Book a Stay',
                              'Login / Join',
                              'Contact Us',
                              'FAQs',
                            ],
                          ),
                        ),

                        SizedBox(
                          width: isMobile
                              ? width - 48
                              : (width - 115) / columnCount,
                          child: _buildContactSection(),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Gold divider
                    Container(
                      height: 0.7,
                      color: gold.withValues(alpha: 0.6),
                    ),

                    const SizedBox(height: 20),

                    // Copyright and legal links
                    if (isMobile)
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '© 2026 BookMyStay. All rights reserved.',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 11,
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Privacy Policy  |  Terms & Conditions',
                            style: TextStyle(
                              color: lightGold,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      )
                    else
                      const Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              '© 2026 BookMyStay. All rights reserved.',
                              style: TextStyle(
                                color: textColor,
                                fontSize: 11,
                              ),
                            ),
                          ),
                          Text(
                            'Privacy Policy  |  Terms & Conditions',
                            style: TextStyle(
                              color: lightGold,
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
        );
      },
    );
  }

  // Brand logo and description
  Widget _buildBrand() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'BookMyStay',
          style: TextStyle(
            color: gold,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: 'Georgia',
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'YOUR STAY, YOUR LUXURY',
          style: TextStyle(
            color: lightGold,
            fontSize: 9,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Discover exceptional stays, memorable experiences, '
          'and warm hospitality with BookMyStay.',
          style: TextStyle(
            color: textColor,
            fontSize: 12,
            height: 1.8,
          ),
        ),
        const SizedBox(height: 18),

        // Social media icons
        Row(
          children: [
            _socialIcon(Icons.facebook),
            const SizedBox(width: 10),
            _socialIcon(Icons.camera_alt_outlined),
            const SizedBox(width: 10),
            _socialIcon(Icons.play_arrow_rounded),
          ],
        ),
      ],
    );
  }

  // Section heading and links
  Widget _buildLinkSection(
    String heading,
    List<String> links,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: const TextStyle(
            color: gold,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.4,
          ),
        ),
        const SizedBox(height: 18),

        ...links.map(
          (link) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () {
                // Add navigation for this link here.
              },
              child: Text(
                link,
                style: const TextStyle(
                  color: textColor,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Contact details
  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'CONTACT US',
          style: TextStyle(
            color: gold,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.4,
          ),
        ),
        const SizedBox(height: 18),

        _contactRow(
          Icons.location_on_outlined,
          'Kampala, Uganda',
        ),
        const SizedBox(height: 14),

        _contactRow(
          Icons.email_outlined,
          'hello@bookmystay.com',
        ),
        const SizedBox(height: 14),

        _contactRow(
          Icons.phone_outlined,
          '+256 700 000 000',
        ),
        const SizedBox(height: 14),

        _contactRow(
          Icons.access_time,
          'Available 24/7',
        ),
      ],
    );
  }

  Widget _contactRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: lightGold,
          size: 17,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: textColor,
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _socialIcon(IconData icon) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        border: Border.all(
          color: gold.withValues(alpha: 0.7),
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          // Add your social media URL here.
        },
        icon: Icon(
          icon,
          color: lightGold,
          size: 17,
        ),
      ),
    );
  }
}
