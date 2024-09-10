import 'package:final_project_hd/domain/entities/user.dart';

class userModel extends User {
  userModel({
    required super.fullName,
    required super.username,
    required super.email,
    required super.password,
    required super.repassword,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'username': username,
      'email': email,
      'password': password,
      'repassword': repassword
    };
  }

  static userModel fromEntity(User user) {
    return userModel(
        fullName: user.fullName,
        username: user.username,
        email: user.email,
        password: user.password,
        repassword: user.repassword);
  }
}
