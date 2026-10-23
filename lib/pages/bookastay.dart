
import 'package:flutter/material.dart';
import 'package:hotelbooking_application_1/pages/appfooter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookAStayPage extends StatefulWidget {
  const BookAStayPage({super.key});

  @override
  State<BookAStayPage> createState() => _BookAStayPageState();
}

class _BookAStayPageState extends State<BookAStayPage> {
  static const Color navy = Color(0xFF0F1B2D);
  static const Color gold = Color(0xFFD4AF37);
  static const Color background = Color(0xFFF8F6F0);

  final TextEditingController _destinationController =
      TextEditingController();

  DateTime? _checkIn;
  DateTime? _checkOut;
  int _guests = 2;
  int _rooms = 1;
 List<Map<String, dynamic>> _bookings = [];

  final List<Map<String, dynamic>> hotels = [
    {
      'name': 'The Royal Grand Hotel',
      'location': 'Dubai, United Arab Emirates',
      'price': 185,
      'rating': 4.9,
      'image': 'assets/images/hotel1.jpg',
      'description': 'Luxury rooms with breathtaking city views.',
    },
    {
      'name': 'Ocean Pearl Resort',
      'location': 'Maldives',
      'price': 250,
      'rating': 4.8,
      'image': 'assets/images/hotel2.jpg',
      'description': 'Relax beside crystal-clear ocean waters.',
    },
    {
      'name': 'Mountain View Retreat',
      'location': 'Switzerland',
      'price': 160,
      'rating': 4.7,
      'image': 'assets/images/hotel3.jpg',
      'description': 'A peaceful escape surrounded by mountains.',
    },
  ];

  @override
  void dispose() {
    _destinationController.dispose();
    super.dispose();
  }
 
Future<void> _bookHotel(Map<String, dynamic> hotel) async {
  final user = FirebaseAuth.instance.currentUser;

if (user == null) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Please sign in before booking.'),
    ),
  );
  return;
}
  if (_checkIn == null || _checkOut == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please select check-in and check-out dates.'),
      ),
    );
    return;
  }

  final nights = _checkOut!.difference(_checkIn!).inDays;

  if (nights <= 0) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Check-out must be after check-in.'),
      ),
    );
    return;
  }

  final booking = <String, dynamic>{
     'userId': user.uid,
    'name': hotel['name'],
    'location': hotel['location'],
    'price': hotel['price'],
    'checkIn': Timestamp.fromDate(_checkIn!),
    'checkOut': Timestamp.fromDate(_checkOut!),
    'nights': nights,
    'guests': _guests,
    'rooms': _rooms,
    'total': (hotel['price'] as num) * nights * _rooms,
    'rating': 0,
    'createdAt': FieldValue.serverTimestamp(),
  };

  try {
    final docRef = await FirebaseFirestore.instance
        .collection('bookings')
        .add(booking);

    if (!mounted) return;

    setState(() {
      _bookings = [
        ..._bookings,
        {
          ...booking,
          'checkIn': _checkIn!,
          'checkOut': _checkOut!,
        },
      ];
    });

    debugPrint('Firebase booking ID: ${docRef.id}');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${hotel['name']} saved to Firebase!'),
      ),
    );
  } catch (e) {
    debugPrint('Firebase booking error: $e');

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Firebase save failed: $e'),
      ),
    );
  }
}

  Future<void> _selectDate({required bool isCheckIn}) async {
    final DateTime today = DateTime.now();

    final DateTime firstDate = isCheckIn
        ? today
        : (_checkIn ?? today);

    final DateTime initialDate = isCheckIn
        ? (_checkIn ?? today)
        : (_checkOut ??
            (_checkIn?.add(const Duration(days: 1)) ??
                today.add(const Duration(days: 1))));

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: DateTime(today.year + 3),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: navy,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: navy,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && mounted) {
      setState(() {
        if (isCheckIn) {
          _checkIn = picked;

          if (_checkOut == null ||
              !_checkOut!.isAfter(picked)) {
            _checkOut = picked.add(const Duration(days: 1));
          }
        } else {
          if (_checkIn != null && picked.isAfter(_checkIn!)) {
            _checkOut = picked;
          }
        }
      });
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Select date';

    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  void _showGuestsDialog() {
    int guests = _guests;
    int rooms = _rooms;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: const Text(
                'Guests and Rooms',
                style: TextStyle(
                  color: navy,
                  fontFamily: 'Georgia',
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _counterRow(
                    title: 'Guests',
                    value: guests,
                    onMinus: () {
                      if (guests > 1) {
                        setDialogState(() => guests--);
                      }
                    },
                    onPlus: () {
                      if (guests < 20) {
                        setDialogState(() => guests++);
                      }
                    },
                  ),
                  const SizedBox(height: 18),
                  _counterRow(
                    title: 'Rooms',
                    value: rooms,
                    onMinus: () {
                      if (rooms > 1) {
                        setDialogState(() => rooms--);
                      }
                    },
                    onPlus: () {
                      if (rooms < 10) {
                        setDialogState(() => rooms++);
                      }
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text(
                    'CANCEL',
                    style: TextStyle(color: navy),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: navy,
                    foregroundColor: gold,
                  ),
                  onPressed: () {
                    setState(() {
                      _guests = guests;
                      _rooms = rooms;
                    });
                    Navigator.pop(dialogContext);
                  },
                  child: const Text('APPLY'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _counterRow({
    required String title,
    required int value,
    required VoidCallback onMinus,
    required VoidCallback onPlus,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: navy,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        IconButton(
          onPressed: onMinus,
          icon: const Icon(Icons.remove_circle_outline),
          color: gold,
        ),
        Text(
          '$value',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          onPressed: onPlus,
          icon: const Icon(Icons.add_circle_outline),
          color: gold,
        ),
      ],
    );
  }

  void _searchHotels() {
    if (_destinationController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a destination.'),
        ),
      );
      return;
    }

    if (_checkIn != null &&
        _checkOut != null &&
        !_checkOut!.isAfter(_checkIn!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Check-out must be after check-in.'),
        ),
      );
      return;
    }

    FocusScope.of(context).unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Searching for stays in ${_destinationController.text.trim()} '
          'for $_guests guests in $_rooms room(s).',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: navy,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'BookMyStay',
          style: TextStyle(
            fontFamily: 'Georgia',
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        actions: [
         
IconButton(
  tooltip: 'My bookings',
  onPressed: () {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SizedBox(
          height: 400,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: _bookings.isEmpty
                ? const Center(
                    child: Text('No bookings yet.'),
                  )
                : ListView.builder(
                    itemCount: _bookings.length,
                    itemBuilder: (context, index) {
                      final booking = _bookings[index];

                      return ListTile(
                        leading: const Icon(
                          Icons.hotel,
                          color: Color(0xFFD4AF37),
                        ),
                        title: Text(booking['name']),
                        subtitle: Text(
                          '${booking['location']}\n'
                          '${booking['nights']} nights • '
                          '${booking['guests']} guests',
                        ),
                        isThreeLine: true,
                        trailing: Text(
                          '\$${booking['total']}',
                        ),
                      );
                    },
                  ),
          ),
        );
      },
    );
  },
  icon: const Icon(Icons.luggage_outlined),
),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Luxury header
              Container(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 35),
                decoration: const BoxDecoration(
                  color: navy,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(28),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'YOUR NEXT ESCAPE',
                      style: TextStyle(
                        color: gold,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Find Your Perfect Stay',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Georgia',
                        fontSize: 29,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Exceptional places. Unforgettable experiences.',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.75),
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 26),

                    // Search form
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'DESTINATION',
                            style: TextStyle(
                              color: navy,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _destinationController,
                            decoration: InputDecoration(
                              hintText: 'Where would you like to go?',
                              prefixIcon: const Icon(
                                Icons.location_on_outlined,
                                color: gold,
                              ),
                              filled: true,
                              fillColor: background,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),

                          // Dates
                          LayoutBuilder(
                            builder: (context, constraints) {
                              final bool narrow =
                                  constraints.maxWidth < 380;

                              final checkIn = _dateField(
                                title: 'CHECK-IN',
                                date: _checkIn,
                                onTap: () =>
                                    _selectDate(isCheckIn: true),
                              );

                              final checkOut = _dateField(
                                title: 'CHECK-OUT',
                                date: _checkOut,
                                onTap: () =>
                                    _selectDate(isCheckIn: false),
                              );

                              if (narrow) {
                                return Column(
                                  children: [
                                    checkIn,
                                    const SizedBox(height: 12),
                                    checkOut,
                                  ],
                                );
                              }

                              return Row(
                                children: [
                                  Expanded(child: checkIn),
                                  const SizedBox(width: 12),
                                  Expanded(child: checkOut),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 18),

                          // Guests and rooms
                          InkWell(
                            onTap: _showGuestsDialog,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: background,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.people_outline,
                                    color: gold,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'GUESTS & ROOMS',
                                          style: TextStyle(
                                            color: navy,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '$_guests guests · $_rooms room(s)',
                                          style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: navy,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),

                          SizedBox(
                            height: 52,
                            child: ElevatedButton.icon(
                              onPressed: _searchHotels,
                              icon: const Icon(Icons.search),
                              label: const Text(
                                'SEARCH STAYS',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: navy,
                                foregroundColor: gold,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Featured hotels
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Handpicked for You',
                      style: TextStyle(
                        fontFamily: 'Georgia',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: navy,
                      ),
                    ),
                    const SizedBox(height: 7),
                    const Text(
                      'Discover exceptional stays around the world.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 20),

                    ...hotels.map((hotel) {
                      return _hotelCard(hotel);
                    }),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.all(24),
                color: navy,
                child: const Column(
                  children: [
                    Text(
                      'BookMyStay',
                      style: TextStyle(
                        color: gold,
                        fontFamily: 'Georgia',
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'YOUR STAY, YOUR LUXURY',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5,),
                 const AppFooter(), 
            ],
          ),
          
        ),
        
      ),
    );
  }

  Widget _dateField({
    required String title,
    required DateTime? date,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: navy,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 9),
            Row(
              children: [
                const Icon(
                  Icons.calendar_month_outlined,
                  size: 17,
                  color: gold,
                ),
                const SizedBox(width: 7),
                Expanded(
                  child: Text(
                    _formatDate(date),
                    style: const TextStyle(
                      color: navy,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _hotelCard(Map<String, dynamic> hotel) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8DDBF)),
        boxShadow: [
          BoxShadow(
            color: navy.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Replace these placeholders with your actual hotel images.
          Container(
            height: 175,
            width: double.infinity,
            color: const Color(0xFFE9E2D2),
            child: const Icon(
              Icons.hotel,
              size: 65,
              color: Color(0xFFBEA877),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        hotel['name'] as String,
                        style: const TextStyle(
                          color: navy,
                          fontFamily: 'Georgia',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.star,
                      color: gold,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${hotel['rating']}',
                      style: const TextStyle(
                        color: navy,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: Colors.black45,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        hotel['location'] as String,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  hotel['description'] as String,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\$${hotel['price']}',
                            style: const TextStyle(
                              color: navy,
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'per night · sample price',
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                onPressed: () => _bookHotel(hotel),      
                               style: ElevatedButton.styleFrom(
                        backgroundColor: navy,
                        foregroundColor: gold,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 13,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                      child: const Text(
                        'BOOK NOW',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
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
  }
}
