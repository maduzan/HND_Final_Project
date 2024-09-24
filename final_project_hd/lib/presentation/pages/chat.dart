import 'package:final_project_hd/domain/entities/chat.dart';
import 'package:final_project_hd/presentation/providers/chatprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Using Provider for state management

class ChatScreen extends StatefulWidget {
  final String senderId; // The employee or customer
  final String receiverId; // The other party

  ChatScreen({required this.senderId, required this.receiverId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Initialize the provider and fetch chat data once when the widget is created
    final chatProvider = Provider.of<Chatprovider>(context, listen: false);
    chatProvider.fetchFechdata(widget.senderId, widget.receiverId);
  }

  @override
  Widget build(BuildContext context) {
    // Initialize the provider to fetch messages
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.receiverId}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<Chatprovider>(
              builder: (context, provider, child) {
                if (provider.fechdataList.isEmpty) {
                  return Center(child: Text("No messages yet"));
                }

                return ListView.builder(
                  reverse: true, // Display newest messages at the bottom
                  itemCount: provider.fechdataList.length,
                  itemBuilder: (context, index) {
                    final message = provider.fechdataList[index];
                    return _buildMessageBubble(message);
                  },
                );
              },
            ),
          ),
          _buildMessageInput(context),
        ],
      ),
    );
  }

  // Widget to build each message bubble
  Widget _buildMessageBubble(Chat chat) {
    bool isSentByMe = chat.senderid == widget.senderId;

    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: isSentByMe ? Colors.blue[100] : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          chat.message,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  // Widget for the message input field
  Widget _buildMessageInput(BuildContext context) {
    final chatProvider = Provider.of<Chatprovider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              if (_messageController.text.isNotEmpty) {
                final newMessage = Chat(
                  senderid: widget.senderId,
                  reseveId: widget.receiverId,
                  message: _messageController.text,
                  timestamp: DateTime.now(),
                );
                chatProvider.addmessage(newMessage);
                _messageController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
