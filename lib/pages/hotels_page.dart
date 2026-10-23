
import 'package:flutter/material.dart';
 import 'package:hotelbooking_application_1/pages/appfooter.dart';

class HotelsPage extends StatelessWidget {
  const HotelsPage({super.key});

  static const Color navy = Color(0xFF0F1B2D);
  static const Color gold = Color(0xFFD4AF37);
  static const Color background = Color(0xFFF8F6F0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Luxury Hotels'),
        backgroundColor: navy,
        foregroundColor: gold,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Find Your Perfect Stay',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              fontFamily: 'Georgia',
              color: navy,
            ),
          ),
          const SizedBox(height: 20),

          hotelCard(
            'Grand Luxury Hotel',
            'Kampala City Centre',
            'UGX 250,000 / night',
            Icons.hotel,
          ),

          hotelCard(
            'Lake View Resort',
            'Entebbe',
            'UGX 320,000 / night',
            Icons.pool,
          ),

          hotelCard(
            'Royal Palace Hotel',
            'Jinja',
            'UGX 180,000 / night',
            Icons.apartment,
          ),
            const AppFooter(), 
        ],
        
      ),
    
    );
  }

  Widget hotelCard(
    String name,
    String location,
    String price,
    IconData icon,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(14),
        leading: Icon(
          icon,
          size: 38,
          color: gold,
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text('$location\n$price'),
        isThreeLine: true,
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
        ),
        onTap: () {},
      ),
        
    );

  }
}
