import 'package:flutter/material.dart';
import 'user_settings_screen.dart'; // Import the user settings screen
import 'chat_screen.dart'; // Import the chat screen

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
  int page = 0;

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
                // Navigate to user settings screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserSettingsScreen(),
                  ),
                );
              },
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
              label: 'EVENT',
              onTapMessage: 'EVENT',
              size: 30,
              onTap: () {
                // Navigate to PlayPosterScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PlayPosterScreen(),
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

// New PlayPosterScreen class
class PlayPosterScreen extends StatelessWidget {
  const PlayPosterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eclipse of the Heart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                '🌟 PRESENTING: "ECLIPSE OF THE HEART" 🌟',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Archabeta',
                ),
              ),
              SizedBox(height: 20),
              Text(
                '🎭 A Theatrical Odyssey of Love, Power, and Tragedy 🎭',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontFamily: 'Archabeta',
                ),
              ),
              SizedBox(height: 20),
              Text(
                '🕯️ Venue: Grand Monarch Theatre\n'
                '🕑 Showtimes:\n'
                'Friday, October 20th - 7:30 PM\n'
                'Saturday, October 21st - 2:00 PM & 7:30 PM\n'
                'Sunday, October 22nd - 3:00 PM',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontFamily: 'Archabeta',
                ),
              ),
              SizedBox(height: 20),
              Text(
                '“Some stories must be felt, not just heard…”',
                style: TextStyle(
                  fontSize: 24,
                  fontStyle: FontStyle.italic,
                  color: Colors.orangeAccent,
                  fontFamily: 'Archabeta',
                ),
              ),
              SizedBox(height: 20),
              Text(
                'ABOUT THE PLAY:\n'
                'In a world where emotions are weaponized and love is a dangerous game, '
                '"Eclipse of the Heart" takes you on a journey into the deepest recesses '
                'of the human soul. Amidst political intrigue and forbidden romance, '
                'alliances crumble, hearts shatter, and only the strongest will survive.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontFamily: 'Archabeta',
                ),
              ),
              SizedBox(height: 20),
              Text(
                'CAST:\n'
                '✨ Alyssa Morgan as Lena\n'
                '✨ Dominic Grey as Marcus\n'
                '✨ Veronica Steele as Zara\n'
                '✨ Jared Knight as Orion\n'
                '\nSpecial musical score by Sebastian Verano.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontFamily: 'Archabeta',
                ),
              ),
              SizedBox(height: 20),
              Text(
                'WHAT TO EXPECT:\n'
                '🔮 Visceral Performances\n'
                '💔 A Story That Defies Time\n'
                '🔊 Immersive Sound & Lighting\n'
                '🎇 Stunning Visuals',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontFamily: 'Archabeta',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
