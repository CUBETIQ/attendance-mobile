import 'package:timesync/feature/report/controller/index.dart';
import 'package:get/get.dart';

class ReportBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => ReportController()),
      ];
}
