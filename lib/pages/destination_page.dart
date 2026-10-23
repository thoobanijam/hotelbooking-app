
import 'package:flutter/material.dart';
import 'package:hotelbooking_application_1/pages/latestoffers.dart';
import 'package:hotelbooking_application_1/pages/appfooter.dart';
class DestinationPage extends StatefulWidget {
  const DestinationPage({super.key});

  @override
  State<DestinationPage> createState() => _DestinationPageState();
}

class _DestinationPageState extends State<DestinationPage> {
  static const Color navy = Color(0xFF0F1B2D);
  static const Color gold = Color(0xFFD4AF37);
  static const Color background = Color(0xFFF8F6F0);

  final TextEditingController _searchController = TextEditingController();

  String selectedCategory = 'All';

  final List<Map<String, dynamic>> destinations = [
    {
      'name': 'Goa',
      'subtitle': 'Beaches, sunsets and luxury resorts',
      'category': 'Beach',
      'image': 'assets/img/R.jpeg',
      'color': Color(0xFFD6E9E8),
      'tag': 'POPULAR',
      'description':
          'Discover golden beaches, beautiful sunsets, beachside resorts and vibrant nightlife.',
    },
    {
      'name': 'Jaipur',
      'subtitle': 'Royal palaces and rich heritage',
      'category': 'Heritage',
      'image': 'assets/img/jaipur.webp',
      'color': Color(0xFFF0D9C8),
      'tag': 'ROYAL ESCAPE',
      'description':
          'Experience grand palaces, historic forts, colourful markets and royal hospitality.',
    },
    {
      'name': 'Kerala',
      'subtitle': 'Backwaters and peaceful nature',
      'category': 'Nature',
      'image': 'assets/img/kereala.webp',
      'color': Color(0xFFDCE8D5),
      'tag': 'SERENE STAY',
      'description':
          'Relax among lush greenery, tranquil backwaters, houseboats and beautiful landscapes.',
    },
    {
      'name': 'Mumbai',
      'subtitle': 'Luxury hotels and city experiences',
      'category': 'City',
      'image': 'assets/img/mumbai.webp',
      'color': Color(0xFFE1DFEC),
      'tag': 'CITY LIFE',
      'description':
          'Enjoy premium city hotels, iconic landmarks, shopping and exciting dining experiences.',
    },
    {
      'name': 'Manali',
      'subtitle': 'Mountain views and cosy retreats',
      'category': 'Nature',
      'image': 'assets/img/manali.webp',
      'color': Color(0xFFD9E6EC),
      'tag': 'MOUNTAIN RETREAT',
      'description':
          'Escape to scenic mountains, peaceful resorts and refreshing Himalayan landscapes.',
    },
    {
      'name': 'Agra',
      'subtitle': 'Timeless monuments and culture',
      'category': 'Heritage',
      'image': 'assets/img/agara.webp',
      'color': Color(0xFFEADFC7),
      'tag': 'CULTURAL GEM',
      'description':
          'Explore the Taj Mahal, historic architecture and the timeless beauty of Indian heritage.',
    },
  ];

  List<Map<String, dynamic>> get filteredDestinations {
    final query = _searchController.text.toLowerCase().trim();

    return destinations.where((destination) {
      final matchesSearch =
          destination['name'].toString().toLowerCase().contains(query) ||
          destination['subtitle'].toString().toLowerCase().contains(query);

      final matchesCategory = selectedCategory == 'All' ||
          destination['category'] == selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showDetails(Map<String, dynamic> destination) {
      final screenHeight = MediaQuery.of(context).size.height;
    showModalBottomSheet(
      context: context,
     backgroundColor: Colors.transparent,
      isScrollControlled: true,
       constraints: BoxConstraints(
         maxHeight: screenHeight - 30,
    ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
        
      ),
      builder: (sheetContext) {
        return Container(
           margin: const EdgeInsets.only(top: 30),
           decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
          child: Padding(
              padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    
                    height: 5,
                    width: 45,
                    decoration: BoxDecoration(
                      
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: destination['color'] as Color,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
  borderRadius: BorderRadius.circular(16),
  child: Image.asset(
    destination['image'] as String,
    width: double.infinity,
    height: 140,
    fit: BoxFit.cover,
  ),
),
                ),
                const SizedBox(height: 20),
                Text(
                  destination['name'] as String,
                  style: const TextStyle(
                    color: navy,
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Georgia',
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  destination['description'] as String,
                  style: const TextStyle(
                    color: Colors.black54,
                    height: 1.6,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: navy,
                      foregroundColor: gold,
                    ),
                    onPressed: () {
                      Navigator.pop(sheetContext);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Selected ${destination['name']}. Connect your hotel search page to continue.',
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'EXPLORE STAYS',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
    body:SafeArea(
      child: SingleChildScrollView(
       physics: const AlwaysScrollableScrollPhysics(),
         child: Container(
            
           child: Column(
             mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
             children: [
                   // COMPONENT 1: Luxury heading
                    Container(
                      padding: const EdgeInsets.fromLTRB(22, 28, 22, 25),
                      decoration: const BoxDecoration(
                        color: navy,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(26),
                        ),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'YOUR JOURNEY BEGINS HERE',
                            style: TextStyle(
                              color: gold,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.5,
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Explore India',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Georgia',
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Discover extraordinary places and find your perfect stay.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                
                    // COMPONENT 2: Search destination
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 22, 18, 16),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (_) => setState(() {}),
                        decoration: InputDecoration(
                          hintText: 'Search Indian destinations...',
                          prefixIcon: const Icon(
                            Icons.search,
                            color: gold,
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {});
                            },
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(vertical: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(
                              color: Color(0xFFE8DDBF),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(
                              color: Color(0xFFE8DDBF),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(
                              color: gold,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                
                    // COMPONENT 3: Category filters
                    SizedBox(
                      height: 46,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        children: ['All', 'Beach', 'Heritage', 'Nature', 'City']
                            .map((category) {
                          final selected = selectedCategory == category;
                
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: ChoiceChip(
                              label: Text(category),
                              selected: selected,
                              onSelected: (_) {
                                setState(() {
                                  selectedCategory = category;
                                });
                              },
                              selectedColor: navy,
                              backgroundColor: Colors.white,
                              labelStyle: TextStyle(
                                color: selected ? gold : navy,
                                fontWeight: FontWeight.w600,
                              ),
                              side: BorderSide(
                                color: selected ? navy : const Color(0xFFE8DDBF),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                
                    // COMPONENT 4: Destination section heading
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 26, 20, 16),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Popular Destinations',
                              style: TextStyle(
                                color: navy,
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Georgia',
                              ),
                            ),
                          ),
                          Text(
                            '${filteredDestinations.length} places',
                            style: const TextStyle(
                              color: Color(0xFF9A7622),
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                
                    // COMPONENT 5: Six destination cards
                    if (filteredDestinations.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(35),
                        child: Column(
                          children: [
                            Icon(
                              Icons.location_off_outlined,
                              size: 45,
                              color: gold,
                            ),
                            SizedBox(height: 12),
                            Text(
                              'No destinations found',
                              style: TextStyle(
                                color: navy,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'Try another destination or category.',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final columns = constraints.maxWidth >= 700 ? 3 : 2;
                
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: filteredDestinations.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: columns,
                                crossAxisSpacing: 13,
                                mainAxisSpacing: 13,
                                mainAxisExtent: 240,
                              ),
                              itemBuilder: (context, index) {
                                final destination = filteredDestinations[index];
                
                                return InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  onTap: () => _showDetails(destination),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: const Color(0xFFE8DDBF),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: navy.withValues(alpha: 0.05),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                              
                   color: destination['color'] as Color,
                   child: Image.asset(
            destination['image'] as String,
            width: double.infinity,
            height: 180,
            fit: BoxFit.cover,
                   ),
                                              ),
                                              Positioned(
                                                top: 10,
                                                left: 10,
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 5,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: navy,
                                                    borderRadius:
                                                        BorderRadius.circular(5),
                                                  ),
                                                  child: Text(
                                                    destination['tag'] as String,
                                                    style: const TextStyle(
                                                      color: gold,
                                                      fontSize: 8,
                                                      fontWeight: FontWeight.bold,
                                                      letterSpacing: 0.5,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const Positioned(
                                                right: 9,
                                                top: 8,
                                                child: Icon(
                                                  Icons.arrow_outward,
                                                  color: navy,
                                                  size: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                            11, 10, 11, 12,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                destination['name'] as String,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  color: navy,
                                                  fontFamily: 'Georgia',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                destination['subtitle'] as String,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 10,
                                                  height: 1.4,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              const Row(
                                                children: [
                                                  Icon(
                                                    Icons.hotel_outlined,
                                                    size: 14,
                                                    color: gold,
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    'Explore destination',
                                                    style: TextStyle(
                                                      color: Color(0xFF9A7622),
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w600,
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
                                );
                              },
                            );
                          },
                        ),
                      ),
                
                    // COMPONENT 6: Luxury promotional banner
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 25, 18, 28),
                      child: Container(
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          color: navy,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.workspace_premium,
                              color: gold,
                              size: 35,
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Your Next Luxury Escape',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Georgia',
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Find a destination that inspires you and discover stays made for unforgettable moments.',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 18),
                            OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  selectedCategory = 'All';
                                  _searchController.clear();
                                });
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: gold,
                                side: const BorderSide(color: gold),
                              ),
                              child: const Text('EXPLORE ALL DESTINATIONS'),
                            ),
                          ],
                        ),
                      ),
                    ),
                       LatestOffersPage(),
                          AppFooter(),  
                 
            ],
                 ),
         ),
    ),
    ),
   
    );
  }
}
