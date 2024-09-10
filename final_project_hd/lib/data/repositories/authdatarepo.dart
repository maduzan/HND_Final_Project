import 'package:final_project_hd/domain/repositories/authrepo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepositoty {
  final FirebaseAuth firebaseAuth;

  AuthRepositoryImpl({required this.firebaseAuth});

  @override
  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }

  @override
  Future<void> authenticate(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Authentication failed: ${e.toString()}');
      throw Exception('Authentication failed: $e');
    }
  }
}
