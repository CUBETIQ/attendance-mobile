import 'package:get/get.dart';
import 'package:timesync/feature/permission/controller/index.dart';

class AppPermissionBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => AppPermissionController()),
      ];
}
