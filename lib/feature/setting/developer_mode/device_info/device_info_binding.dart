import 'package:get/get.dart';
import 'package:timesync/feature/setting/developer_mode/device_info/controller/device_info_controller.dart';

class DeviceInfoBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => DeviceInfoController()),
      ];
}
