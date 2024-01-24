import 'package:attendance_app/feature/organization/controller/index.dart';
import 'package:get/get.dart';

class OrganizationBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => OrganizationController()),
      ];
}
