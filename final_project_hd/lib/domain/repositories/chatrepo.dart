import 'package:final_project_hd/domain/entities/chat.dart';

abstract class Chatrepo {
  Future<void> addmessage(Chat chat);
  Stream<List<Chat>> getmessage(String senderid, String reseveId);
}
