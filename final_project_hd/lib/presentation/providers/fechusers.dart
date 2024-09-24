import 'package:final_project_hd/domain/entities/eplumber.dart';
import 'package:final_project_hd/domain/usecase/plumberusecase.dart';
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  final Plumberusecase plumberusecase;

  DataProvider({required this.plumberusecase});

  List<Plumber> _dataList = [];

  List<Plumber> get dataList => _dataList;

  List<Plumber> _dataListc = [];

  List<Plumber> get dataListc => _dataListc;

  List<Plumber> _dataListee = [];

  List<Plumber> get dataListee => _dataListee;

  List<Plumber> _dataListbui = [];

  List<Plumber> get dataListbui => _dataListbui;

  List<Plumber> _dataListpt = [];

  List<Plumber> get dataListpt => _dataListpt;

  void fechdata() {
    plumberusecase.fechp().listen((data) {
      _dataList = data;
      notifyListeners(); // Notify the UI to update
    });
  }

  void fechdatac() {
    plumberusecase.fechc().listen((dataa) {
      _dataListc = dataa;
      notifyListeners(); // Notify the UI to update
    });
  }

  void fechdataee() {
    plumberusecase.fechee().listen((data) {
      _dataListee = data;
      notifyListeners(); // Notify the UI to update
    });
  }

  void fechdatat() {
    plumberusecase.fechpt().listen((data) {
      _dataListbui = data;
      notifyListeners(); // Notify the UI to update
    });
  }

  void fechdatabui() {
    plumberusecase.fechbui().listen((data) {
      _dataListpt = data;
      notifyListeners(); // Notify the UI to update
    });
  }
}
