import 'package:archa/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'user_settings_screen.dart'; // Import the user settings screen

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
                  fontSize: 40))),
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
                label: ' USER',
                onTapMessage: 'USER',
                size: 40,
                onTap: () {
                // Navigate to user settings screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserSettingsScreen()),
                );
              },
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 50,
          color: const Color(0xFFFF4C00),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            FlashTextWidget(
              label: ' HOME ',
              onTapMessage: 'HOME',
              size: 30,
              onTap: () {},
            ),
            FlashTextWidget(
              label: ' CHAT ',
              onTapMessage: 'CHAT',
              size: 30,
              onTap: () {
                // Navigate to user settings screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatScreen()),
                );
              },
            ),
            FlashTextWidget(
              label: ' ABOUT ',
              onTapMessage: 'ABOUT',
              size: 30,
              onTap: () {},
            ),
          ]),
        ));
  }
}

class FlashTextWidget extends StatefulWidget {
  final String label;
  final String onTapMessage;
  final double? size;
  final VoidCallback onTap;
  const FlashTextWidget(
      {super.key,
      required this.label,
      required this.onTapMessage,
      required this.size,
      required this.onTap});

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
    debugPrint('${widget.onTapMessage} TAPPED');
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _currentColor = const Color(0xFF000000);
    });
    widget.onTap();
    debugPrint('${widget.onTapMessage} TAP RELEASED');
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