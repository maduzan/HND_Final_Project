import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_hd/data/model/fechdata_model.dart';
import 'package:final_project_hd/domain/entities/fechdata.dart';
import 'package:final_project_hd/domain/repositories/fech_data_repo.dart';

class DataReopFaechdata implements FechDataRepo {
  final FirebaseFirestore firestore;

  DataReopFaechdata({required this.firestore});

  @override
  Stream<List<Fechdata>> getData() {
    return firestore.collection('Jobrall').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => FechdataModel.fromFirestore(doc))
          .toList();
    });
  }
}
