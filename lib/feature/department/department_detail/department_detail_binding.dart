import 'package:get/get.dart';
import 'package:timesync360/feature/department/department_detail/controller/index.dart';

class DepartmentDetailBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => DepartmentDetailController()),
      ];
}
