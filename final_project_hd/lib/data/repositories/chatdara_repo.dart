import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_hd/data/model/chatmodel.dart';
import 'package:final_project_hd/domain/entities/chat.dart';
import 'package:final_project_hd/domain/repositories/chatrepo.dart';

class ChatdaraRepo extends Chatrepo {
  final FirebaseFirestore firestore;
  ChatdaraRepo({required this.firestore});

  @override
  Future<void> addmessage(Chat chat) async {
    final chatmodel = Chatmodel.fromEntity(chat);
    await firestore.collection('chat').add(chatmodel.toMap());
  }

  @override
  Stream<List<Chat>> getmessage(String senderid, String reseveId) {
    return firestore
        .collection('chats')
        .where('senderId',
            isEqualTo: senderid) // Use the method parameter 'senderid'
        .where('receiverId',
            isEqualTo: reseveId) // Use the method parameter 'reseveId'
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Chatmodel.fromFirestore(doc)).toList();
    });
  }
}
