import 'package:final_project_hd/domain/repositories/authrepo.dart';
import 'package:final_project_hd/domain/entities/user.dart';

class Authenticateusecase {
  final AuthRepositoty authrepositoty;

  Authenticateusecase({required this.authrepositoty});

  Future<void> call(String email, String password) async {
    return await authrepositoty.authenticate(email, password);
  }

  Future<void> signUp(User user) {
    return authrepositoty.signUpWithEmailAndPassword(user.email, user.password);
  }
}
