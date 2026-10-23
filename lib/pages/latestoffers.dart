
import 'package:flutter/material.dart';

class LatestOffersPage extends StatelessWidget {
  const LatestOffersPage({super.key});

  static const Color gold = Color.fromARGB(255, 121, 109, 2);
  final List<Map<String, String>> offers = const [
     {
      'image': 'assets/img/intholiday.webp',
      'title': 'DISCOVER PARADISE',
      'content':
          'Enjoy beautiful beaches, relaxing stays, and unforgettable adventures.',
          
    },
    {
      'image': 'assets/img/palace.jpeg',
      'title': 'FESITVAL OF INDIA',
      'content':
          'Discover a world of luxury and convenience at Taj Bangalore, where contemporary design.',
    },
    {
      'image': 'assets/img/city.webp',
      'title': 'THE CITY SPECIAL',
      'content':
          'Embrace luxury and  where contemporary design, fine dining, and warm hospitality await.',
    },
  ];
  @override
 
@override
Widget build(BuildContext context) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final isMobile = constraints.maxWidth < 600;

      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : 32,
          vertical: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isMobile) ...[
              _buildHeading(true),
              const SizedBox(height: 12),
              _buildDescription(),
            ] else
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildHeading(false),
                  const SizedBox(width: 24),
                  Expanded(
                    child: _buildDescription(),
                  ),
                ],
              ),

            const SizedBox(height: 24),

            // Offer cards appear below the heading and description.
            _latestofferList(isMobile),
          ],
        ),
      );
    },
  );
}

  Widget _buildHeading(bool isMobile) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: isMobile ? 60 : 100,
          height: 1,
          color: gold,
        ),
        const SizedBox(width: 12),
        const Text(
          'Latest Offers',
          style: TextStyle(
            color: gold,
            fontSize: 20,
            fontFamily: 'Georgia',
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return const Text(
      'Dive into cool adventures at our picture-perfect destinations with BookMyStay Hotels.',
      style: TextStyle(
        fontSize: 12,
        height: 1.5,
      ),
    );
  }


  Widget _latestofferList(bool isMobile){
  return LayoutBuilder(
    builder: (context, constraints) {
      final crossAxisCount = constraints.maxWidth >= 900
            ? 3
            : constraints.maxWidth >= 600
                ? 2
                : 1;

      return GridView.builder(
     shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: offers.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            mainAxisExtent: 400,
          ),
        itemBuilder: (context, index) {
          final offer = offers[index];
          return Card(
              margin: const EdgeInsets.all(10),
             
              color: const Color.fromARGB(255, 247, 242, 229),
                elevation: 4,

            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                     
                children: [
                  Image.asset(
                    offer['image']!,
                    fit: BoxFit.cover,
                     width: double.infinity,
          height: 160,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      offer['title']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      offer['content']!,
                      style: const TextStyle(
                        fontSize: 12,
                        height: 1.5,
                      ),
                    ),
                    
                  ),
                  SizedBox(height: 8),
                   TextButton(
        onPressed: () {
          // Add navigation here
        },
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFF796D02),
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
        ),
        child: const Text('Read More →'),
      ),
                ],
              ),
            
            ),
          );
        },
      );
    },
  );
}

}

