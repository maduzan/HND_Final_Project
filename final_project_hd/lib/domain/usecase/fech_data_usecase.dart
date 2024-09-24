import 'package:final_project_hd/domain/entities/fechdata.dart';
import 'package:final_project_hd/domain/repositories/fech_data_repo.dart';

class FechDataUsecase implements FechDataRepo {
  final FechDataRepo fechDataRepo;

  FechDataUsecase({required this.fechDataRepo});

  @override
  Stream<List<Fechdata>> getData() {
    return fechDataRepo.getData();
  }
}
