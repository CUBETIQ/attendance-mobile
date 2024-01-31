import 'package:timesync360/feature/home/summary_attendance/controller/index.dart';
import 'package:get/get.dart';

class SummaryAttendanceBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => SummaryAttendanceController()),
      ];
}
