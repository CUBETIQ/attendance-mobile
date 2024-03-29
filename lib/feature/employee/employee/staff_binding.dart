import 'package:timesync/feature/employee/employee/controller/index.dart';
import 'package:get/get.dart';

class StaffBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => StaffController()),
      ];
}
