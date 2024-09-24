import 'package:final_project_hd/domain/entities/chat.dart';
import 'package:final_project_hd/domain/repositories/chatrepo.dart';

class Chatusecase implements Chatrepo {
  final Chatrepo chatrepo;

  Chatusecase({required this.chatrepo});

  @override
  Future<void> addmessage(Chat chat) {
    return chatrepo.addmessage(chat);
  }

  @override
  Stream<List<Chat>> getmessage(String senderid, String reseveId) {
    return chatrepo.getmessage(senderid, reseveId);
  }
}
