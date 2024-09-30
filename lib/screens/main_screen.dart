import 'package:flutter/material.dart';
import 'user_settings_screen.dart'; // Import the user settings screen
import 'chat_screen.dart'; // Import the chat screen
import 'tickets_screen.dart'; // Import the tickets screen

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

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("ARCHA+"),
            FlashTextWidget(
              label: 'USER',
              onTapMessage: 'USER',
              size: 40,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const UserSettingsScreen()));
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView( // Added SingleChildScrollView for scrolling
        child: Column(
          children: const [
            ScreenplayWidget(
              title: 'The Tempest',
              description:
                  'A shipwreck, a magical island, a sorcerer, and spirits.',
              venue: 'The Globe Theatre',
              showtimes: '19:00, 20:00, 21:00',
              price: 250,
              availableTickets: 100,
              rating: 4.5,
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
              label: 'HOME',
              onTapMessage: 'HOME',
              size: 30,
              onTap: () {},
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
                    builder: (context) => TicketsScreen(),
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

class FlashTextWidget extends StatefulWidget {
  final String label;
  final String onTapMessage;
  final double? size;
  final VoidCallback onTap;

  const FlashTextWidget({
    super.key,
    required this.label,
    required this.onTapMessage,
    required this.size,
    required this.onTap,
  });

  @override
  _FlashTextWidgetState createState() => _FlashTextWidgetState();
}

class _FlashTextWidgetState extends State<FlashTextWidget> {
  Color _currentColor = const Color(0xFF000000);
  final Color _flashColor = const Color(0xFF7F2500);

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _currentColor = _flashColor;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _currentColor = const Color(0xFF000000);
    });
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: () {
        setState(() {
          _currentColor = const Color(0xFF000000);
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        child: Text(
          widget.label,
          style: TextStyle(fontSize: widget.size, color: _currentColor),
        ),
      ),
    );
  }
}

// Define the ScreenplayWidget class that expands on click
class ScreenplayWidget extends StatefulWidget {
  final String title;
  final String description;
  final String venue;
  final String showtimes;
  final double price;
  final int availableTickets;
  final double rating;

  const ScreenplayWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.venue,
    required this.showtimes,
    required this.price,
    required this.availableTickets,
    required this.rating,
  }) : super(key: key);

  @override
  _ScreenplayWidgetState createState() => _ScreenplayWidgetState();
}

class _ScreenplayWidgetState extends State<ScreenplayWidget> {
  bool _expanded = false; // Track whether details are expanded

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _expanded = !_expanded; // Toggle the expanded state
        });
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
                '🎭 ${widget.title} 🎭',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.orangeAccent,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.description,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                '🕯️ Venue: ${widget.venue}',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 5),
              Text(
                '🕑 Showtimes: ${widget.showtimes}',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 5),
              Text(
                '💰 Ticket Price: ${widget.price} Kč',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 5),
              Text(
                '🔖 Available Tickets: ${widget.availableTickets}',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 10),
              // Display rating as stars
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < widget.rating ? Icons.star : Icons.star_border,
                    color: Colors.orangeAccent,
                  );
                }),
              ),
              if (_expanded) ...[
                const SizedBox(height: 10),
                // Expanded details
                Text(
                  'This is where additional details about the play can be shown, such as actors, directors, and special effects.',
                  style: const TextStyle(fontSize: 16, color: Colors.orangeAccent),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
