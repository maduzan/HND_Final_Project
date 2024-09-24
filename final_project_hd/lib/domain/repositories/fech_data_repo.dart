import 'package:final_project_hd/domain/entities/fechdata.dart';

abstract class FechDataRepo {
  Stream<List<Fechdata>> getData();
}
