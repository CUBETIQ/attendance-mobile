import 'package:get/get.dart';
import 'package:timesync/feature/customer_support/support/controller/index.dart';

class CustomerSupportBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => CustomerSupportController()),
      ];
}
