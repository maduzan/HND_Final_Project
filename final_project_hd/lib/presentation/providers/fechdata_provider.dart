import 'package:final_project_hd/domain/entities/fechdata.dart';
import 'package:final_project_hd/domain/repositories/fech_data_repo.dart';
import 'package:final_project_hd/domain/usecase/fech_data_usecase.dart';
import 'package:flutter/foundation.dart';

class FechdataProvider extends ChangeNotifier {
  final FechDataUsecase fechDataUsecase;

  FechdataProvider({required this.fechDataUsecase});

  List<Fechdata> _fechdataList = [];

  List<Fechdata> get fechdataList => _fechdataList;

  void fetchFechdata() {
    fechDataUsecase.getData().listen((data) {
      _fechdataList = data;
      notifyListeners(); // Notify the UI to update
    });
  }
}
