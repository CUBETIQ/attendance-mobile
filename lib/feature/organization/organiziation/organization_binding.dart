import 'package:timesync/feature/organization/organiziation/controller/index.dart';
import 'package:get/get.dart';

class OrganizationBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => OrganizationController()),
      ];
}
