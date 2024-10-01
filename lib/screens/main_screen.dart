import 'package:flutter/material.dart';
import 'user_settings_screen.dart'; // Import the user settings screen
import 'chat_screen.dart'; // Import the chat screen
import 'tickets_screen.dart'; // Import the tickets screen
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firebase Firestore
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:intl/intl.dart'; // For formatting dates
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
    super.key,
    required this.label,
    required this.onTapMessage,
    required this.size,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
              title: 'Burkicom: Slunce',
              description:
                  'Soubor současného fyzického divadla Burkicom uvede svou novinku Slunce, která je apokalyptickou sci-fi o lidskosti...',
              venue: 'ARCHA+',
              showtimes: 'Čt 10.10. 20:00 | Pá 11.10. 20:00 ',
              price: 550,
              availableTickets: 100,
              rating: 4.5,
              details: "",
            ),
            ScreenplayWidget(
              title: 'Bby Eco + Casey MQ',
              description:
                  'Hyperpopové bublinky plné čirých emocí a návraty k přírodě...',
              venue: 'ARCHA+',
              showtimes: 'St 09.10. 21:00',
              price: 400,
              availableTickets: 50,
              rating: 4.0,
              details: "",
            ),
            ScreenplayWidget(
              title: 'Dreams',
              description:
                  'Forma koncertního provedení audiovizuálního charakteru...',
              venue: 'ARCHA+',
              showtimes: 'Út 22.10. 20:00',
              price: 400,
              availableTickets: 75,
              rating: 4.2,
              details: "",
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
                title,
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
                '⭐ Rating: $rating/5',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GameDetailsScreen extends StatefulWidget {
  final String title;
  final String description;
  final String venue;
  final String showtimes;
  final double price;
  final int availableTickets;
  final double rating;
  final String details;

  const GameDetailsScreen({
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
  _GameDetailsScreenState createState() => _GameDetailsScreenState();
}

class _GameDetailsScreenState extends State<GameDetailsScreen> {
  bool _isLoading = false; // This will control the loading screen
  TextEditingController commentController = TextEditingController();

  // Function to handle ticket purchase and updating Firestore
  Future<void> _buyTicket() async {
    setState(() {
      _isLoading = true; // Show the loading screen
    });

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String email = user.email!;

      try {
        // Fetch the current buyers and unbox array length
        DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
            .collection('tickets')
            .doc(widget.title)
            .get();

        // Safely cast the data to Map<String, dynamic>
        Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;

        // Check if the data exists, otherwise initialize the lists
        List buyers = data?['buyers'] != null ? List.from(data!['buyers']) : [];
        List unbox = data?['unbox'] != null ? List.from(data!['unbox']) : [];

        // Get the current length (next available index)
        int currentLength = buyers.length;

        // Add the new email and unbox value at the next index
        buyers.insert(currentLength, email);
        unbox.insert(currentLength, false);

        // Perform the Firebase operation
        await FirebaseFirestore.instance
            .collection('tickets')
            .doc(widget.title)
            .update({
          'buyers': buyers,
          'unbox': unbox,
        });

        setState(() {
          _isLoading = false; // Hide the loading screen
        });

        // Optionally show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ticket purchased successfully!')),
        );
      } catch (e) {
        setState(() {
          _isLoading = false; // Hide the loading screen
        });

        // Show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to purchase ticket: $e')),
        );
      }
    } else {
      setState(() {
        _isLoading = false; // Hide the loading screen
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User not logged in!')),
      );
    }
  }

  // Function to submit a comment to Firestore
  Future<void> _submitComment(String comment) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String email = user.email!;
      try {
        await FirebaseFirestore.instance
            .collection('tickets')
            .doc(widget.title)
            .collection('comments')
            .add({
          'email': email,
          'comment': comment,
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Comment submitted successfully!')),
        );

        // Clear the comment field after submission
        commentController.clear();
      } catch (e) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit comment: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User not logged in!')),
      );
    }
  }

  // Function to format Firestore timestamps into readable date format
  String _formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('dd MMM yyyy, HH:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(widget.title),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.description,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
                const SizedBox(height: 10),
                Text(
                  '🕯️ Venue: ${widget.venue}',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(height: 10),
                Text(
                  '🕑 Showtimes: ${widget.showtimes}',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(height: 10),
                Text(
                  '💰 Ticket Price: ${widget.price} Kč',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(height: 10),
                Text(
                  '⭐ Rating: ${widget.rating}/5',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _buyTicket,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF4C00),
                  ),
                  child: const Text('Buy Ticket'),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: commentController,
                  decoration: const InputDecoration(
                    labelText: 'Enter your comment',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    String comment = commentController.text;
                    if (comment.isNotEmpty) {
                      _submitComment(comment);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF4C00),
                  ),
                  child: const Text('Submit Comment'),
                ),
                const SizedBox(height: 20),

                // Display the list of comments below the submit button
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('tickets')
                        .doc(widget.title)
                        .collection('comments')
                        .orderBy('timestamp', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final comments = snapshot.data!.docs;

                      return ListView.builder(
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          var commentData = comments[index];
                          String email = commentData['email'];
                          String comment = commentData['comment'];
                          Timestamp? timestamp = commentData['timestamp'] as Timestamp?;
                          DateTime date = timestamp?.toDate() ?? DateTime.now();

                          String formattedDate =
                              timestamp != null ? _formatTimestamp(timestamp) : '';

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.grey[900],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        email,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        formattedDate,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    comment,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
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
              ],
            ),
          ),
        ),
        // Loading screen overlay
        if (_isLoading)
          const ModalBarrier(
            dismissible: false,
            color: Colors.black54,
          ),
        if (_isLoading)
          const Center(
            child: CircularProgressIndicator(
              color: Colors.orange,
            ),
          ),
      ],
    );
  }
}
