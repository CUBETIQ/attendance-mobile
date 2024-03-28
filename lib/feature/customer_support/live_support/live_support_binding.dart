import 'package:get/get.dart';
import 'package:timesync/feature/customer_support/live_support/controller/index.dart';

class LiveSupportBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.put(LiveSupportController(), permanent: true),
      ];
}
