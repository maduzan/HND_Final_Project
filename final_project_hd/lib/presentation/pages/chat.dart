import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String userId; // User ID for sending messages
  final String documentId; // Instructor ID

  const ChatScreen({
    required this.userId,
    required this.documentId,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<DocumentSnapshot> messages = []; // Store messages here

  @override
  void initState() {
    super.initState();
    // Listen to messages related to the instructor
    FirebaseFirestore.instance
        .collection('chats')
        .where('instructorId',
            isEqualTo: widget.documentId) // Check only instructorId
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      setState(() {
        messages = snapshot.docs; // Update the messages list on data change
      });
    });
  }

  void sendMessage(String message) {
    if (message.trim().isEmpty) return;

    // Send the message with a sender field
    FirebaseFirestore.instance.collection('chat').add({
      'memberId': widget.userId, // Store user ID for context
      'adminId': widget.documentId,
      'message': message,
      'sender': 'user', // Indicate the sender as user
      'timestamp': FieldValue.serverTimestamp(),
    });

    _messageController.clear(); // Clear input field after sending the message
    _scrollToBottom(); // Scroll to the bottom after sending
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              controller: _scrollController,
              reverse: true, // Show the latest message at the bottom
              children: messages.map((doc) {
                final messageData = doc.data() as Map<String, dynamic>?;

                // Use null-aware operator to handle potential nulls
                final messageText =
                    messageData?['message'] ?? 'Invalid message';
                final sender =
                    messageData?['sender'] ?? 'user'; // Default to user

                // Determine the styling based on the sender
                final isUserMessage = sender == 'user';
                return Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  alignment: isUserMessage
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    color: isUserMessage ? Colors.blue[200] : Colors.green[200],
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        messageText,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      labelText: 'Type a message...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: sendMessage,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    sendMessage(_messageController.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
