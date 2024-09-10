abstract class AuthRepositoty {
  Future<void> authenticate(String email, String password);

  Future<void> signUpWithEmailAndPassword(String email, String password);
}
