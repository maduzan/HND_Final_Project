import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_hd/domain/entities/chat.dart';

class Chatmodel extends Chat {
  Chatmodel({
    required super.senderid,
    required super.reseveId,
    required super.message,
    required super.timestamp,
  });

  // Converts the Chatmodel to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'senderid': senderid,
      'reseveId': reseveId,
      'message': message,
      'timestamp': timestamp,
    };
  }

  // Factory constructor to create Chatmodel from Firestore
  factory Chatmodel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    // Using the correct Firestore field names
    return Chatmodel(
      senderid: data['senderid'] ?? 'Unknown Sender',
      reseveId: data['reseveId'] ?? 'Unknown Receiver',
      message: data['message'] ?? 'No message',
      timestamp: data['timestamp'] ?? Timestamp.now(), // Use default if null
    );
  }

  // Converts a Chat entity into a Chatmodel
  static Chatmodel fromEntity(Chat chat) {
    return Chatmodel(
      senderid: chat.senderid,
      reseveId: chat.reseveId,
      message: chat.message,
      timestamp: chat.timestamp,
    );
  }
}
