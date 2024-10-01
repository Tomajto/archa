import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'market.dart';
import 'main_screen.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({super.key});

  @override
  _TicketsScreenState createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  User? _user = FirebaseAuth.instance.currentUser;

  // Fetch tickets from Firestore where the user has bought tickets
  Future<List<QueryDocumentSnapshot>> _fetchTickets() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('tickets')
        .where('buyers', arrayContains: _user?.email)
        .get();
    return snapshot.docs;
  }

  // Unbox ticket function
  Future<void> _unboxTicket(String ticketTitle) async {
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection('tickets')
        .doc(ticketTitle)
        .get();

    List buyers = docSnapshot['buyers'];
    List unbox = docSnapshot['unbox'];

    if (buyers.length != unbox.length) {
      throw Exception(
          'Data inconsistency: buyers and unbox arrays must have the same length.');
    }

    for (int i = 0; i < buyers.length; i++) {
      if (buyers[i] == _user!.email && unbox[i] == false) {
        setState(() {
          unbox[i] = true;
        });
        break;
      }
    }

    await FirebaseFirestore.instance
        .collection('tickets')
        .doc(ticketTitle)
        .update({
      'unbox': unbox,
    });
  }

  // Navigate to Market and refresh TicketsScreen when coming back
  Future<void> _navigateToMarket() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Market()),
    );
    // Refresh the tickets after returning from Market
    setState(() {});
  }

  // Show dialog to resell tickets
  void _showResellDialog(String title, int availableTickets) {
    showDialog(
      context: context,
      builder: (context) {
        int ticketsToResell = 0;
        double price = 0;

        return AlertDialog(
          title: Text('Resell Tickets for $title'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('You have $availableTickets tickets. How many would you like to resell?'),
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Number of Tickets'),
                onChanged: (value) {
                  ticketsToResell = int.tryParse(value) ?? 0;
                },
              ),
              const SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Set Price'),
                onChanged: (value) {
                  price = double.tryParse(value) ?? 0;
                },
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (ticketsToResell > 0 && ticketsToResell <= availableTickets && price > 0) {
                  _resellTickets(title, ticketsToResell, price);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a valid number of tickets and price.')),
                  );
                }
              },
              child: const Text('Resell'),
            ),
          ],
        );
      },
    );
  }

  // Resell tickets and update Firestore
  Future<void> _resellTickets(String ticketTitle, int numberToResell, double price) async {
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection('tickets')
        .doc(ticketTitle)
        .get();

    List buyers = docSnapshot['buyers'];
    List unbox = docSnapshot['unbox'];

    int ticketsToResell = numberToResell;

    if (buyers.length != unbox.length) {
      throw Exception(
          'Data inconsistency: buyers and unbox arrays must have the same length.');
    }

    for (int i = 0; i < buyers.length && ticketsToResell > 0; i++) {
      if (buyers[i] == _user!.email && unbox[i] == false) {
        // Remove ticket from user's possession
        buyers.removeAt(i);
        unbox.removeAt(i);
        ticketsToResell--;

        // Add the ticket to the marketplace after removal with the price
        await _addTicketToMarketplace(ticketTitle, price);
        
        i--;
      }
    }

    // Update Firestore with the modified arrays
    await FirebaseFirestore.instance
        .collection('tickets')
        .doc(ticketTitle)
        .update({
      'buyers': buyers,
      'unbox': unbox,
    });

    // Refresh the screen after reselling
    setState(() {});
  }

  // Add ticket to marketplace
  Future<void> _addTicketToMarketplace(String ticketTitle, double price) async {
    await FirebaseFirestore.instance.collection('marketplace').add({
      'ticketTitle': ticketTitle,
      'sellerEmail': _user?.email,
      'timestamp': FieldValue.serverTimestamp(),
      'price': price, // The price set by the user
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF4C00),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'TICKETS',
              style: TextStyle(
                fontFamily: 'Archabeta',
                fontWeight: FontWeight.bold,
                fontSize: 40,
                color: Colors.black,
              ),
            ),
            FlashTextWidget(
              label: 'MARKET',
              onTapMessage: 'MARKET',
              size: 30,
              onTap: _navigateToMarket, // Navigates to Market and refreshes when back
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<QueryDocumentSnapshot>>(
        future: _fetchTickets(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No tickets available.',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final ticketDocs = snapshot.data!;

          return ListView.builder(
            itemCount: ticketDocs.length,
            itemBuilder: (context, index) {
              var ticketData = ticketDocs[index];
              var title = ticketData.id;
              List buyers = ticketData['buyers'];
              List unbox = ticketData['unbox'];

              if (buyers.length != unbox.length) {
                return Card(
                  color: Colors.grey[900],
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Data inconsistency in $title',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                );
              }

              int totalOwned = buyers.where((buyer) => buyer == _user!.email).length;
              int unboxedCount = unbox.asMap().entries.where((entry) => entry.value == true && buyers[entry.key] == _user!.email).length;
              int unboxedAvailable = totalOwned - unboxedCount;

              return Card(
                color: Colors.grey[900],
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (unboxedCount > 0) {
                            // Handle navigating to ticket details
                          }
                        },
                        child: Text(
                          title,
                          style: const TextStyle(
                            color: Colors.orangeAccent,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Total Tickets: $totalOwned',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Unboxed Tickets: $unboxedCount',
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 10),

                      // Warning message for unboxing tickets
                      const Text(
                        'If you unbox a ticket, you can\'t resell it anymore.',
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: unboxedAvailable > 0
                                ? () => _unboxTicket(title)
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: unboxedAvailable > 0
                                  ? const Color(0xFFFF4C00)
                                  : Colors.grey,
                            ),
                            child: const Text('Unbox One'),
                          ),
                          ElevatedButton(
                            onPressed: unboxedAvailable > 0
                                ? () => _showResellDialog(title, unboxedAvailable)
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: unboxedAvailable > 0
                                  ? const Color(0xFFFF4C00)
                                  : Colors.grey,
                            ),
                            child: const Text('Resell'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
