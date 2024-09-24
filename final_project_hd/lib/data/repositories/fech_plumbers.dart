import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_hd/data/model/fechplumber_model.dart';
import 'package:final_project_hd/domain/entities/eplumber.dart';

import 'package:final_project_hd/domain/repositories/fechplumber.dart';

class FechPlumbers extends Fechplumberrepo {
  final FirebaseFirestore firestore;

  FechPlumbers({required this.firestore});
  @override
  Stream<List<Plumber>> fechp() {
    return firestore
        .collection('users')
        .where('jobroll',
            isEqualTo:
                'Plumber') // Filter for documents where 'jobRole' is 'plumber'
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => FechplumberModel.fromFirestore(doc))
          .toList();
    });
  }

  @override
  Stream<List<Plumber>> fechc() {
    return firestore
        .collection('users')
        .where('jobroll',
            isEqualTo:
                'Carpenter') // Filter for documents where 'jobRole' is 'plumber'
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => FechplumberModel.fromFirestore(doc))
          .toList();
    });
  }

  @override
  Stream<List<Plumber>> fechpt() {
    return firestore
        .collection('users')
        .where('jobroll',
            isEqualTo:
                'Technition') // Filter for documents where 'jobRole' is 'plumber'
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => FechplumberModel.fromFirestore(doc))
          .toList();
    });
  }

  @override
  Stream<List<Plumber>> fechbui() {
    return firestore
        .collection('users')
        .where('jobroll',
            isEqualTo:
                'Builder') // Filter for documents where 'jobRole' is 'plumber'
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => FechplumberModel.fromFirestore(doc))
          .toList();
    });
  }

  @override
  Stream<List<Plumber>> fechee() {
    return firestore
        .collection('users')
        .where('jobroll',
            isEqualTo:
                'Electition') // Filter for documents where 'jobRole' is 'plumber'
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => FechplumberModel.fromFirestore(doc))
          .toList();
    });
  }
}
