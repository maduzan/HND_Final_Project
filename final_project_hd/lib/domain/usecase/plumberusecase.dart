import 'package:final_project_hd/data/repositories/fech_plumbers.dart';
import 'package:final_project_hd/domain/entities/eplumber.dart';
import 'package:final_project_hd/domain/repositories/fechplumber.dart';

class Plumberusecase implements Fechplumberrepo {
  final Fechplumberrepo prepo;

  Plumberusecase({
    required this.prepo,
  });
  @override
  Stream<List<Plumber>> fechp() {
    return prepo.fechp();
  }

  @override
  Stream<List<Plumber>> fechee() {
    return prepo.fechee();
  }

  @override
  Stream<List<Plumber>> fechpt() {
    return prepo.fechpt();
  }

  @override
  Stream<List<Plumber>> fechc() {
    return prepo.fechc();
  }

  @override
  Stream<List<Plumber>> fechbui() {
    return prepo.fechbui();
  }
}
