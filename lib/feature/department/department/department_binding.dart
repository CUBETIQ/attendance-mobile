import 'package:get/get.dart';
import 'package:timesync/feature/department/department/controller/index.dart';

class DepartmentBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => DepartmentController()),
      ];
}
