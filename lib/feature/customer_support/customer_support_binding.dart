import 'package:timesync360/feature/customer_support/controller/index.dart';
import 'package:get/get.dart';

class CustomerSupportBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => CustomerSupportController()),
      ];
}
