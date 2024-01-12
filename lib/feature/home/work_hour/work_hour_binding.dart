import 'package:attendance_app/feature/home/work_hour/controller/index.dart';
import 'package:get/get.dart';

class WorkingHourBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => WorkHourController()),
      ];
}
