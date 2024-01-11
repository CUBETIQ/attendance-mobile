import 'package:attendance_app/feature/home/admin_leave_request/controller/index.dart';
import 'package:get/get.dart';

class AdminLeaveRequestBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => AdminLeaveRequestController()),
      ];
}
