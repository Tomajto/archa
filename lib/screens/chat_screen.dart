import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _roomNameController = TextEditingController();
  final TextEditingController _participantController = TextEditingController();

  String? _username;
  String? _selectedRoom;
  List<String> _participants = [];
  List<DocumentSnapshot> _chatRooms = [];

  @override
  void initState() {
    super.initState();
    _loadUsername();
    _fetchChatRooms();
  }

  // Load username from SharedPreferences
  void _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? 'Anonymous';
    });
  }

  // Fetch all chat rooms from Firestore
  void _fetchChatRooms() async {
    FirebaseFirestore.instance
        .collection('chats')
        .where('participants', arrayContains: _username)
        .snapshots()
        .listen((snapshot) {
      setState(() {
        _chatRooms = snapshot.docs;
      });
    });
  }

  // Create a new chat room
  void _createChatRoom() async {
    if (_roomNameController.text.isEmpty || _participantController.text.isEmpty) {
      return;
    }

    // Split participants by commas
    _participants = _participantController.text.split(',').map((e) => e.trim()).toList();
    _participants.add(_username!); // Add the current user to the participants list

    // Create the room in Firestore
    DocumentReference roomRef =
        await FirebaseFirestore.instance.collection('chats').add({
      'roomName': _roomNameController.text,
      'participants': _participants,
    });

    setState(() {
      _selectedRoom = roomRef.id; // Automatically open the newly created room
      _participants = []; // Clear participants list
    });

    // ignore: use_build_context_synchronously
    Navigator.pop(context); // Close the dialog
  }

  // Send message to Firestore
  void _sendMessage() {
    if (_messageController.text.isEmpty || _selectedRoom == null) return;

    FirebaseFirestore.instance
        .collection('chats')
        .doc(_selectedRoom)
        .collection('messages')
        .add({
      'username': _username,
      'message': _messageController.text,
      'timestamp': FieldValue.serverTimestamp(),
    });

    _messageController.clear();
  }

  // Dialog to create a new chat room
  Future<void> _showCreateRoomDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: const Text('Create a new chat room',
              style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _roomNameController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Room Name',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              TextField(
                controller: _participantController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Add participants (comma separated)',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Create', style: TextStyle(color: Colors.orange)),
              onPressed: () {
                _createChatRoom();
                Navigator.pop(context);
              },
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
        title: const Text('CHAT ROOMS'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showCreateRoomDialog, // Open dialog to create room
          ),
        ],
      ),
      body: _selectedRoom == null
          ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _chatRooms.length,
                    itemBuilder: (context, index) {
                      var room = _chatRooms[index];

                      // Safely access roomName, provide default value if missing
                      String roomName = room.data() != null &&
                              (room.data() as Map<String, dynamic>)
                                  .containsKey('roomName')
                          ? (room.data() as Map<String, dynamic>)['roomName']
                          : 'Unnamed Room';

                      List<dynamic> participants = room.data() != null &&
                              (room.data() as Map<String, dynamic>)
                                  .containsKey('participants')
                          ? (room.data()
                              as Map<String, dynamic>)['participants']
                          : [];

                      return ListTile(
                        title: Text(
                          roomName,
                          style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Participants: ${participants.join(', ')}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          setState(() {
                            _selectedRoom = room.id; // Set selected room
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            )
          : Column(
              children: [
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('chats')
                        .doc(_selectedRoom)
                        .collection('messages')
                        .orderBy('timestamp', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      var messages = snapshot.data!.docs;
                      return ListView.builder(
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          var message = messages[index];
                          return ListTile(
                            title: Text(
                              message['username'] ?? 'Unknown User',
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            subtitle: Text(
                              message['message'],
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                // Input field to send a message
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            labelText: 'Enter your message...',
                            labelStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send, color: Colors.white),
                        onPressed: _sendMessage,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
