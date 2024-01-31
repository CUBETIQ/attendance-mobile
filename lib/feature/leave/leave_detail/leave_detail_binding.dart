import 'package:timesync360/feature/leave/leave_detail/controller/index.dart';
import 'package:get/get.dart';

class LeaveDetailBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => LeaveDetailController()),
      ];
}
