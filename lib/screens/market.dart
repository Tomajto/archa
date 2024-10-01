import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Market extends StatefulWidget {
  const Market({super.key});

  @override
  _MarketState createState() => _MarketState();
}

class _MarketState extends State<Market> {
  User? _user = FirebaseAuth.instance.currentUser;

  // Fetch market tickets
  Future<List<QueryDocumentSnapshot>> _fetchMarketTickets() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('marketplace').get();
    return snapshot.docs;
  }

  // Buy ticket and move it to 'tickets' collection
  Future<void> _buyTicket(
      String ticketTitle, String ticketId, double price) async {
    try {
      DocumentSnapshot ticketDoc = await FirebaseFirestore.instance
          .collection('tickets')
          .doc(ticketTitle)
          .get();

      List buyers = ticketDoc['buyers'];
      List unbox = ticketDoc['unbox'];

      // Add the buyer's email and false to the respective arrays
      buyers.add(_user!.email);
      unbox.add(false);

      // Update Firestore with the new buyer and unbox data
      await FirebaseFirestore.instance
          .collection('tickets')
          .doc(ticketTitle)
          .update({
        'buyers': buyers,
        'unbox': unbox,
      });

      // Remove the ticket from the 'marketplace' after purchase
      await FirebaseFirestore.instance
          .collection('marketplace')
          .doc(ticketId)
          .delete();

      // Notify the user of the successful purchase
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ticket purchased successfully!')),
      );

      // Refresh the market page to reflect changes
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to buy the ticket: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF4C00),
        centerTitle: true,
        title: const Text(
          'Market',
          style: TextStyle(
            fontFamily: 'Archabeta',
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.black,
          ),
        ),
      ),
      body: FutureBuilder<List<QueryDocumentSnapshot>>(
        future: _fetchMarketTickets(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No tickets available in the market.',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final marketTickets = snapshot.data!;

          return ListView.builder(
            itemCount: marketTickets.length,
            itemBuilder: (context, index) {
              var ticketData = marketTickets[index];
              var ticketId = ticketData.id;
              var ticketTitle = ticketData['ticketTitle'];
              var sellerEmail = ticketData['sellerEmail'];
              var price = ticketData['price'];

              // Ensure price is always treated as double
              double ticketPrice = (price is int) ? price.toDouble() : price;

              return Card(
                color: Colors.grey[900],
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ticketTitle,
                        style: const TextStyle(
                          color: Colors.orangeAccent,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Seller: $sellerEmail',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Price: ${ticketPrice.toStringAsFixed(2)} Kč',
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () => _buyTicket(ticketTitle, ticketId, ticketPrice),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF4C00),
                        ),
                        child: Text(
                          'Buy Ticket',
                          style: TextStyle(color: Colors.grey[900]), // Change the color here
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
    );
  }
}
