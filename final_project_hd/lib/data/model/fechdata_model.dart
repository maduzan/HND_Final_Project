import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_hd/domain/entities/fechdata.dart';

class FechdataModel extends Fechdata {
  FechdataModel({
    required super.name,
    required super.Discriotion,
    required super.ImageUrl,
  });

  factory FechdataModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;

    return FechdataModel(
      name: data?['name'] ?? 'Unknown', // Provide default value if null
      Discriotion: data?['Discription'] ??
          'No description', // Provide default value if null
      ImageUrl: data?['ImageUrl'] ?? '', // Provide default value if null
    );
  }

  static FechdataModel fromEntity(Fechdata fechdata) {
    return FechdataModel(
      name: fechdata.name,
      Discriotion: fechdata.Discriotion,
      ImageUrl: fechdata.ImageUrl,
    );
  }
}
