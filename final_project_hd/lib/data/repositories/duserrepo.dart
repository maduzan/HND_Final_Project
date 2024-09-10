import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_hd/data/model/usermodle.dart';
import 'package:final_project_hd/domain/entities/user.dart';
import 'package:final_project_hd/domain/repositories/userrepo.dart';

class UserRepositoryImpl implements Userrepo {
  final FirebaseFirestore firestore;

  UserRepositoryImpl(this.firestore);

  @override
  Future<void> add(User user) async {
    final usermodel = userModel.fromEntity(user);
    await firestore.collection('users').add(usermodel.toMap());
  }
}
