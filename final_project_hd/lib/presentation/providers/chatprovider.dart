import 'package:final_project_hd/domain/entities/chat.dart';
import 'package:final_project_hd/domain/usecase/chatusecase.dart';
import 'package:flutter/material.dart';

class Chatprovider extends ChangeNotifier {
  final Chatusecase chatusecase;
  Chatprovider({required this.chatusecase});

  Chat? _chat;
  Chat? get senderid => _chat;

  Chat? _chatt;
  Chat? get reseveId => _chatt;

  List<Chat> _fechdataList = [];

  List<Chat> get fechdataList => _fechdataList;

  void fetchFechdata(String senderId, String reseveId) {
    chatusecase.getmessage(senderid as String, reseveId).listen((data) {
      _fechdataList = data;
      notifyListeners(); // Notify the UI to update
    });
  }

  Future<void> addmessage(Chat chat) async {
    await chatusecase.addmessage(chat);
    notifyListeners();
  }
}
