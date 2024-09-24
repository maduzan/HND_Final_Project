import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_hd/domain/entities/eplumber.dart';

class FechplumberModel extends Plumber {
  FechplumberModel(
      {required super.fullName,
      required super.username,
      required super.email,
      required super.jobrall});

  factory FechplumberModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FechplumberModel(
        fullName: data['fullName'] ?? '',
        username: data['username'] ?? '',
        email: data['email'] ?? '',
        jobrall: data['jobroll'] ?? '');
  }
  static FechplumberModel fromEntity(Plumber pp) {
    return FechplumberModel(
        fullName: pp.fullName,
        username: pp.username,
        email: pp.email,
        jobrall: pp.jobrall);
  }
}

/*class FechCarpenterModel extends Carpenter {
  FechCarpenterModel(
      {required super.fullName,
      required super.username,
      required super.email,
      required super.jobrall});

  factory FechCarpenterModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FechCarpenterModel(
        fullName: data['fullName'] ?? '',
        username: data['username'] ?? '',
        email: data['email'] ?? '',
        jobrall: data['jobroll'] ?? '');
  }
  static FechplumberModel fromEntity(Plumber pp) {
    return FechplumberModel(
        fullName: pp.fullName,
        username: pp.username,
        email: pp.email,
        jobrall: pp.jobrall);
  }
}*/