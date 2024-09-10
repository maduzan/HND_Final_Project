import 'package:final_project_hd/domain/entities/user.dart';
import 'package:final_project_hd/domain/usecase/uscaseuser.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  final AddUser addUser;

  UserProvider({required this.addUser});

  Future<void> add(User user) async {
    await addUser(user);
    notifyListeners();
  }
}
