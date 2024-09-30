import 'package:flutter/material.dart';
import 'user_settings_screen.dart'; // Import the user settings screen
import 'chat_screen.dart'; // Import the chat screen
import 'resell_screen.dart'; // Import the resell screen

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
  // Function to show the play details dialog popup with buy option
  void _showPlayDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          content: const Text(
            '🎭 A Theatrical Odyssey of Love, Power, and Tragedy 🎭\n\n'
            '🕯️ Venue: Grand Monarch Theatre\n'
            '🕑 Showtimes:\n'
            'Friday, October 20th - 7:30 PM\n'
            'Saturday, October 21st - 2:00 PM & 7:30 PM\n'
            'Sunday, October 22nd - 3:00 PM\n\n'
            'ABOUT THE PLAY:\n'
            'In a world where emotions are weaponized and love is a dangerous game, '
            '"Eclipse of the Heart" takes you on a journey into the deepest recesses '
            'of the human soul. Amidst political intrigue and forbidden romance, '
            'alliances crumble, hearts shatter, and only the strongest will survive.\n\n'
            'CAST:\n✨ Alyssa Morgan as Lena\n✨ Dominic Grey as Marcus\n'
            '✨ Veronica Steele as Zara\n✨ Jared Knight as Orion\n\n'
            'Special musical score by Sebastian Verano.\n\n'
            '🔖 TICKETS AVAILABLE: 120\n'
            '💰 PRICE: \$50',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontFamily: 'Archabeta',
            ),
            textAlign: TextAlign.left,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'Close',
                style: TextStyle(color: Colors.orangeAccent),
              ),
            ),
            TextButton(
              onPressed: () {
                // Add ticket purchase logic here
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'Buy Tickets',
                style: TextStyle(color: Colors.orangeAccent),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : Row(
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
        ],)
       
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row with Play Title and Rating
            Row(
              children: [
                // Play title button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0x00000000), // Transparent background
                    padding: const EdgeInsets.all(0), // Remove extra padding
                  ),
                  onPressed: () {
                    _showPlayDetailsDialog(context); // Show play details popup with buy option
                  },
                  child: const Text(
                    '🌟 "ECLIPSE OF THE HEART" 🌟',
                    style: TextStyle(
                      fontSize: 34, // Increase font size for the title
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Archabeta',
                    ),
                  ),
                ),
                const SizedBox(width: 10), // Space between title and stars
                // 4 out of 5 star rating
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < 4 ? Icons.star : Icons.star_border, // 4 stars filled, 1 empty
                      color: Colors.orangeAccent,
                    );
                  }),
                ),
              ],
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
                // Navigate to chat screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChatScreen(),
                  ),
                );
              },
            ),
            FlashTextWidget(
              label: 'RESELL',
              onTapMessage: 'RESELL',
              size: 30,
              onTap: () {
                // Navigate to resell screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ResellScreen(),
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
