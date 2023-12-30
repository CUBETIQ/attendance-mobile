import 'package:get/get.dart';
import 'controller/index.dart';

class LeaveBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => LeaveController()),
      ];
}
