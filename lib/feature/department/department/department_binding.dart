import 'package:get/get.dart';
import 'package:timesync360/feature/department/department/controller/index.dart';

class DepartmentBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => DepartmentController()),
      ];
}
