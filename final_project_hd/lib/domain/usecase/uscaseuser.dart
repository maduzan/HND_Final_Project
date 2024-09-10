import 'package:final_project_hd/domain/entities/user.dart';
import 'package:final_project_hd/domain/repositories/userrepo.dart';

class AddUser {
  final Userrepo userrepo;

  AddUser({required this.userrepo});

  Future<void> call(User user) async {
    await userrepo.add(user);
  }
}
