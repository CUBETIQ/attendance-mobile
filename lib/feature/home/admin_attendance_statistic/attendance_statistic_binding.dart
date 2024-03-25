import 'package:get/get.dart';
import 'package:timesync/feature/home/admin_attendance_statistic/controller/index.dart';

class AttendanceStatisticBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => AttendanceStatisticController()),
      ];
}
