import 'package:final_project_hd/domain/usecase/authusecase.dart';
import 'package:final_project_hd/domain/entities/authuser.dart';
import 'package:final_project_hd/domain/entities/user.dart';
import 'package:flutter/material.dart';

class Authprovider extends ChangeNotifier {
  final Authenticateusecase authenticateusecase;

  Authprovider({required this.authenticateusecase});

  Authuser? _user;
  Authuser? get user => _user;

  Future<void> login(String email, String password) async {
    await authenticateusecase(email, password);
    notifyListeners();
  }

  Future<void> signUp(User user) async {
    await authenticateusecase.signUp(user);
  }
}
