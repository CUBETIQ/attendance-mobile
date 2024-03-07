import 'package:get/get.dart';
import 'package:timesync/feature/department/department_detail/controller/index.dart';

class DepartmentDetailBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => DepartmentDetailController()),
      ];
}
