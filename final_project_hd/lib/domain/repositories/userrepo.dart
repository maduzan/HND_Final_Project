import 'package:final_project_hd/domain/entities/user.dart';

abstract class Userrepo {
  Future<void> add(User user);
}
