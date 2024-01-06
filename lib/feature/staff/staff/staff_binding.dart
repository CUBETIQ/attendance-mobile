import 'package:attendance_app/feature/staff/staff/controller/index.dart';
import 'package:get/get.dart';

class StaffBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => StaffController()),
      ];
}
