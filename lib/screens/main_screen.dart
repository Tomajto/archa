import 'package:flutter/material.dart';
import 'user_settings_screen.dart'; // Import the user settings screen
import 'chat_screen.dart'; // Import the chat screen
import 'tickets_screen.dart'; // Import the tickets screen
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firebase Firestore
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF000000),
        fontFamily: 'Archabeta',
        navigationBarTheme: const NavigationBarThemeData(
          backgroundColor: Color(0xffff4c00),
          indicatorColor: Color(0x00000000),
          shadowColor: Color(0x00000000),
          surfaceTintColor: Color(0x00000000),
        ),
        appBarTheme: const AppBarTheme(
          color: Color(0xFFff4c00),
          foregroundColor: Color(0xFF000000),
          titleTextStyle: TextStyle(
            color: Color(0xFF000000),
            fontFamily: 'Archabeta',
            fontWeight: FontWeight.w700,
            fontSize: 40,
          ),
        ),
      ),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class FlashTextWidget extends StatelessWidget {
  final String label;
  final String onTapMessage;
  final double? size;
  final VoidCallback onTap;

  const FlashTextWidget({
    Key? key,
    required this.label,
    required this.onTapMessage,
    required this.size,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // This is where your `onTap` is used
      child: Text(
        label,
        style: TextStyle(fontSize: size ?? 20.0),
      ),
    );
  }
}

class _RootPageState extends State<RootPage> {
  String _selectedFlag = 'assets/vlajka_cr.png'; // Default flag

  // This function is called when the user selects a different flag
  void _changeFlag(String newFlag) {
    setState(() {
      _selectedFlag = newFlag;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("ARCHA+"),
            DropdownButton<String>(
              value: _selectedFlag,
              icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
              underline: Container(), // Remove the underline
              dropdownColor: const Color(0xFFFF4C00),
              onChanged: (String? newFlag) {
                if (newFlag != null) {
                  _changeFlag(newFlag);
                }
              },
              items: [
                DropdownMenuItem(
                  value: 'assets/vlajka_uk.png',
                  child: Row(
                    children: [
                      Image.asset('assets/vlajka_uk.png',
                          width: 24, height: 24),
                      const SizedBox(width: 8),
                      const Text("English",
                          style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'assets/vlajka_cr.png',
                  child: Row(
                    children: [
                      Image.asset('assets/vlajka_cr.png',
                          width: 24, height: 24),
                      const SizedBox(width: 8),
                      const Text("Čeština",
                          style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'assets/vlajka_viet.png',
                  child: Row(
                    children: [
                      Image.asset('assets/vlajka_viet.png',
                          width: 24, height: 24),
                      const SizedBox(width: 8),
                      const Text("Vietnamština",
                          style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            ScreenplayWidget(
              title: 'The Tempest',
              description:
                  'A shipwreck, a magical island, a sorcerer, and spirits.',
              venue: 'The Globe Theatre',
              showtimes: '19:00, 20:00, 21:00',
              price: 250,
              availableTickets: 100,
              rating: 4.5,
              details: "Details about The Tempest.",
            ),
            ScreenplayWidget(
              title: 'Romeo and Juliet',
              description:
                  'Two star-crossed lovers from feuding families fall in love.',
              venue: 'The Globe Theatre',
              showtimes: '19:00, 20:00, 21:00',
              price: 200,
              availableTickets: 50,
              rating: 4.0,
              details: "Details about Romeo and Juliet.",
            ),
            ScreenplayWidget(
              title: 'Macbeth',
              description:
                  'A Scottish general becomes king after hearing a prophecy.',
              venue: 'The Globe Theatre',
              showtimes: '19:00, 20:00, 21:00',
              price: 300,
              availableTickets: 75,
              rating: 4.2,
              details: "Details about Macbeth.",
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: const Color(0xFFFF4C00),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FlashTextWidget(
              label: 'USER',
              onTapMessage: 'USER',
              size: 30,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserSettingsScreen()));
              },
            ),
            FlashTextWidget(
              label: 'CHAT',
              onTapMessage: 'CHAT',
              size: 30,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChatScreen(),
                  ),
                );
              },
            ),
            FlashTextWidget(
              label: 'TICKETS',
              onTapMessage: 'TICKETS',
              size: 30,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TicketsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ScreenplayWidget extends StatelessWidget {
  final String title;
  final String description;
  final String venue;
  final String showtimes;
  final double price;
  final int availableTickets;
  final double rating;
  final String details;

  const ScreenplayWidget({
    super.key,
    required this.title,
    required this.description,
    required this.venue,
    required this.showtimes,
    required this.price,
    required this.availableTickets,
    required this.rating,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to a new screen with more details and the buy/rate/comment option
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameDetailsScreen(
              title: title,
              description: description,
              venue: venue,
              showtimes: showtimes,
              price: price,
              availableTickets: availableTickets,
              rating: rating,
              details: details,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        color: Colors.grey[900],
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '🎭 $title 🎭',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.orangeAccent,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                description,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                '🕯️ Venue: $venue',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 5),
              Text(
                '🕑 Showtimes: $showtimes',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 5),
              Text(
                '💰 Ticket Price: $price Kč',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 5),
              Text(
                '🔖 Available Tickets: $availableTickets',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 10),
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: Colors.orangeAccent,
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GameDetailsScreen extends StatelessWidget {
  final String title;
  final String description;
  final String venue;
  final String showtimes;
  final double price;
  final int availableTickets;
  final double rating;
  final String details;

  GameDetailsScreen({
    required this.title,
    required this.description,
    required this.venue,
    required this.showtimes,
    required this.price,
    required this.availableTickets,
    required this.rating,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description: $description',
                style: const TextStyle(fontSize: 18, color: Colors.white)),
            const SizedBox(height: 10),
            Text('Venue: $venue',
                style: const TextStyle(fontSize: 18, color: Colors.white)),
            const SizedBox(height: 10),
            Text('Showtimes: $showtimes',
                style: const TextStyle(fontSize: 18, color: Colors.white)),
            const SizedBox(height: 10),
            Text('Ticket Price: $price Kč',
                style: const TextStyle(fontSize: 18, color: Colors.white)),
            const SizedBox(height: 10),
            Text('Available Tickets: $availableTickets',
                style: const TextStyle(fontSize: 18, color: Colors.white)),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color(0xFFff4c00), // Button background color (replaces primary)
              ),
              onPressed: () {
                // Handle ticket buying logic here
              },
              child: const Text('Buy Ticket',
                  style: const TextStyle(fontSize: 18, color: Colors.black)),
            ),
            const SizedBox(height: 20),
            const Text('Rate this event:',
                style: TextStyle(fontSize: 18, color: Colors.white)),
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < rating ? Icons.star : Icons.star_border,
                  color: Colors.orangeAccent,
                );
              }),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(labelText: 'Leave a Comment'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color(0xFFff4c00), // Button background color (replaces primary)
              ),
              onPressed: () {
                // Handle comment submission here
              },
              child: const Text('Submit Comment', style: TextStyle(fontSize: 18, color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
